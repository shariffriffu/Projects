package com.visiontek.cloudpos_selfdiag;
import android.Manifest;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.cloudpos.DeviceException;
import com.cloudpos.OperationListener;
import com.cloudpos.OperationResult;
import com.cloudpos.POSTerminal;
import com.cloudpos.TimeConstants;
import com.cloudpos.card.Card;
import com.cloudpos.card.MifareCard;
import com.cloudpos.rfcardreader.RFCardReaderDevice;
import com.cloudpos.rfcardreader.RFCardReaderOperationResult;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;

public class Rfid extends AppCompatActivity {
    private static final int REQUEST_STORAGE_WRITE_SDCARD_open = 90;
    byte[] result;
    Context mContext;
    boolean verifyResult;
    public Button read, write, tap_the_card, get_id;
    private RFCardReaderDevice device = null;
    Card rfCard;
    int sectorIndex = 1;
    int blockIndex = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rfid);
        mContext = this;

        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_STORAGE_WRITE_SDCARD_open);

        if (device == null) {
            device = (RFCardReaderDevice) POSTerminal.getInstance(mContext)
                    .getDevice("cloudpos.device.rfcardreader");
        }

        read = findViewById(R.id.read);
        write = findViewById(R.id.write);
        tap_the_card = findViewById(R.id.tap);
        get_id = findViewById(R.id.get_id);
         buttonsColor(false);
        try {
            device.open();
            System.out.println("RFID open success");
            buttonTapColor(true);
        } catch (DeviceException e) {
            System.out.println("RFID open failed");
            e.printStackTrace();
        }

    tap_the_card.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            System.out.println("onClick is running");
            try {
                OperationListener listener = new OperationListener() {
                    @Override
                    public void handleResult(OperationResult arg0) {
                        if (arg0.getResultCode() == OperationResult.SUCCESS) {
                            System.out.println("************FIND CARD SUCCEED");
                            rfCard = ((RFCardReaderOperationResult) arg0).getCard();
                            System.out.println("************ Card Type" + rfCard.toString());
                            runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        buttonsColor(true);
                                        dialogbox("tap the card success", true);
                                    }
                                });
                        } else {
                            System.out.println("************FIND CARD FAILED");
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    dialogbox("tap card failed", false);
                                }
                            });

                        }
                    }
                };
                device.listenForCardPresent(listener, TimeConstants.FOREVER);
            } catch (DeviceException e) {
                e.printStackTrace();
                System.out.println("************FIND CARD ERROR " + e.toString());
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        dialogbox("tap card failed", false);
                    }
                });

            }
        }
    });
        read.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");
                if (card_verify()) {
                    try {
                        result = ((MifareCard) rfCard).readBlock(sectorIndex, blockIndex);
                        System.out.println(Arrays.toString(result));
                       dialogbox(hexToAscii(result),true);
                    } catch (DeviceException e) {
                        e.printStackTrace();
                        dialogbox("Read failed",false);
                    }
                }else {
                    dialogbox("Key verify failed",false);
                }
            }
        });
        get_id.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                //               if (verifyResult) {
                    try {
                        byte[] cardID = rfCard.getID();
                        //System.out.println(Arrays.toString(cardID));
                        System.out.println(hexToString(cardID));
                        dialogbox(hexToString(cardID),true);
                    } catch (DeviceException e) {
                        e.printStackTrace();
                        dialogbox("Get ID failed",false);
                    }
                //}
            }
        });
        write.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                if (card_verify()) {
                    byte[] arryData = new byte[16];// 随机创造16个字节的数组
                    for (int i = 0; i < 16; i++) {
                        arryData[i] = (byte) 0x38;
                    }
                    try {
                        ((MifareCard) rfCard).writeBlock(sectorIndex, blockIndex, arryData);
                        dialogbox("write success",true);
                    } catch (DeviceException e) {
                        e.printStackTrace();
                        dialogbox("write failed",false);
                    }
                }else {
                    dialogbox("Key verify failed",false);
                }
            }
        });
    }
    boolean card_verify(){
        System.out.println("card_verify is running");
        byte[] key = new byte[]{(byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF, (byte) 0xFF};
        try {
            verifyResult = ((MifareCard) rfCard).verifyKeyA(sectorIndex, key);
            System.out.println("************ VERIFY SUCCEED" + verifyResult);
            //return true;
        } catch (DeviceException e) {
            e.printStackTrace();
            System.out.println("************ VERIFY FAILED " + e.toString());
            //return false;
        }
        return verifyResult;
    }
    private void buttonsColor(boolean enabled) {
        System.out.println("buttonsColor is running");

        write.setEnabled(enabled);
        read.setEnabled(enabled);
        if (enabled) {
            read.setTextColor(getResources().getColor(R.color.colorAccent));
            write.setTextColor(getResources().getColor(R.color.colorAccent));

        } else {
            read.setTextColor(getResources().getColor(R.color.colorPrimary));
            write.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
    }

    private void buttonTapColor(boolean enabled) {
        System.out.println("buttonTapColor is running");
        tap_the_card.setEnabled(enabled);
        if (enabled) {
            tap_the_card.setTextColor(getResources().getColor(R.color.colorAccent));
        } else {
            tap_the_card.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
    }

    private String hexToAscii(byte[] t1){
        System.out.println("hexToAscii is running");

        String utf = null;
        try {
             utf = new String(t1, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return utf;
    }
    private String hexToString(byte[] t1) {
        System.out.println("hexToString is running");
        String strOut = new String("");
        for (int i = 0; i < t1.length; i++)
            strOut += String.format("%02X ", t1[i]);
        return strOut;
    }

    private void dialogbox(String msg, final boolean btns) {
        System.out.println("dialogbox is running");
        AlertDialog.Builder alert = new AlertDialog.Builder(Rfid.this);
        alert.setTitle("RFID");
        alert.setCancelable(false);
        alert.setMessage(msg);
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        if (!btns) {
                            buttonsColor(false);
                            buttonTapColor(true);
                        }else {
                            buttonsColor(true);
                            buttonTapColor(false);
                        }
                    }
                });
        alert.show();
    }
    @Override
    protected void onDestroy() {
        System.out.println("onDestroy is running");
        try {
            device.close();
            System.out.println("*********** CLOSE SUCCESS");
        } catch (DeviceException e) {
            e.printStackTrace();
            System.out.println("*********** CLOSE FAILED "+e.toString());
        }
        super.onDestroy();
    }
    @Override
    protected void onRestart() {
        System.out.println("********************onRestart");
        buttonTapColor(true);
        buttonsColor(false);
        super.onRestart();
    }

}