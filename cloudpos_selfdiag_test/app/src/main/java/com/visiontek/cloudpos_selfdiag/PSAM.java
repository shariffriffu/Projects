package com.visiontek.cloudpos_selfdiag;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.appcompat.app.AppCompatActivity;

import com.cloudpos.DeviceException;
import com.cloudpos.OperationListener;
import com.cloudpos.OperationResult;
import com.cloudpos.POSTerminal;
import com.cloudpos.TimeConstants;
import com.cloudpos.card.CPUCard;
import com.cloudpos.card.Card;
import com.cloudpos.card.SLE4442Card;
import com.cloudpos.smartcardreader.SmartCardReaderDevice;
import com.cloudpos.smartcardreader.SmartCardReaderOperationResult;

import java.nio.charset.StandardCharsets;

public class PSAM extends AppCompatActivity {

    private SmartCardReaderDevice device = null;
    private static final String TAG = "PSAM";
    private EditText valueText = null;
    private Card psamCard;
    Button cardPresence, connect, read, write, noOfRecords, format;
    Context context;
    int flag=0;
    int logicalID = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_psam);
        Log.d(TAG, "PSAM: onCreate called");
        context = this;
        if (device == null) {
            device = (SmartCardReaderDevice) POSTerminal.getInstance(context)
                    .getDevice("cloudpos.device.smartcardreader",logicalID);
        }

        cardPresence = findViewById(R.id.cardPresence);
        connect =findViewById(R.id.connect);
        read = findViewById(R.id.read);
        write = findViewById(R.id.write);
        valueText =  findViewById(R.id.writedata);
        noOfRecords = findViewById(R.id.noOfRecords);
        format = findViewById(R.id.format);
        try {
            device.open(logicalID);
            cardPresence.setEnabled(true);
            cardPresence.setTextColor(getResources().getColor(R.color.colorAccent));
            connect.setTextColor(getResources().getColor(R.color.colorPrimary));
            connect.setEnabled(false);
            System.out.println("psam open success");
        } catch (DeviceException e) {
            cardPresence.setTextColor(getResources().getColor(R.color.colorPrimary));
            cardPresence.setEnabled(false);
            connect.setTextColor(getResources().getColor(R.color.colorPrimary));
            connect.setEnabled(false);
            dialogbox("psam open failed");
            e.printStackTrace();
        }
        buttonsColor(false);

        cardPresence.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");
                flag=0;
                try {
                    OperationListener listener = new OperationListener() {
                        @Override
                        public void handleResult(OperationResult arg0) {
                            if (arg0.getResultCode() == OperationResult.SUCCESS) {
                                System.out.println("PSAM card present success");
                                psamCard = ((SmartCardReaderOperationResult) arg0).getCard();
                            } else {
                                System.out.println("PSAM card present failed");
                            }
                            runOnUiThread(new Runnable() {
                                @Override
                                public void run() {
                                    dialogbox("PSAM card presence successed");
                                    cardPresence.setTextColor(getResources().getColor(R.color.colorPrimary));
                                    cardPresence.setEnabled(false);
                                    connect.setTextColor(getResources().getColor(R.color.colorAccent));
                                    connect.setEnabled(true);
                                }
                            });
                        }
                    };
                    device.listenForCardPresent(listener, TimeConstants.FOREVER);
                } catch (DeviceException e) {
                    e.printStackTrace();
                    dialogbox("PSAM Card Not Present");

                }
            }
        });
        connect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                try {
                    com.cloudpos.card.ATR atr = ((SLE4442Card) psamCard).connect();
                    System.out.println("PSAM power ON success");
                    byte[] arryAPDU = new byte[] {
                            0x00, 0x20, 0x00, 0x00, 0x05, 0x55, 0x55, 0x55, 0x55, 0x55
                    };
                    flag=1;
                    connect.setTextColor(getResources().getColor(R.color.colorPrimary));
                    connect.setEnabled(false);
                    buttonsColor(true);
                    String transmit=hexToString(((CPUCard)psamCard).transmit(arryAPDU));
                    if(transmit.charAt(0)=='9'&&transmit.charAt(1)=='0'
                            &&transmit.charAt(2)==' '&&transmit.charAt(3)=='0' && transmit.charAt(4)=='0'){
                        dialogbox("ATR:\n"+hexToString(atr.getBytes())+"\n"+"PSAM verify success");
                        System.out.println("PSAM verify success");
                    }
                } catch (DeviceException e) {
                    e.printStackTrace();
                }
            }
        });
        write.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                byte[] arryAPDU = new byte[] {
                        0x00, (byte) 0xDA, 0x00, 0x00, 0x05, 0x34, 0x32, 0x31, 0x35, 0x33
                };
                try {
                    byte[] apduResponse = ((CPUCard)psamCard).transmit(arryAPDU);
                    String str = hexToString(apduResponse);
                    if(str.charAt(0) =='9' && str.charAt(1) == '0') {
                        System.out.println("PSAM write success");
                        dialogbox("PSAM Write success");
                    }
                    else {
                        System.out.println("PSAM write failed");
                        dialogbox("PSAM write failed");
                    }
                } catch (DeviceException e) {
                    System.out.println("PSAM write failed");
                    dialogbox("PSAM write failed");
                    e.printStackTrace();
                }
            }
        });
        read.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                byte[] arryAPDU1 = new byte[] {
                        0x00, 0x22, 0x00, 0x00, 0x02
                };
                int record = 0;
                try {
                    byte[] apduResponse = ((CPUCard)psamCard).transmit(arryAPDU1);
                    String str = hexToString(apduResponse);
                    record = apduResponse[1];
                    if(record == 0)
                        dialogbox("No record found");
                } catch (DeviceException e) {
                    e.printStackTrace();
                }
                if(record > 0) {
                    String s = null;
                    int i = 0;
                    try {
                        byte[] arryAPDU = new byte[]{
                                0x00, (byte) 0xCA, 0x00, 0x01, 0x42
                        };

                        byte[] apduResponse = ((CPUCard) psamCard).transmit(arryAPDU);
                        String str = hexToString(apduResponse);
                        if (str.charAt(0) == '6' && (str.charAt(1) == 'A') || str.charAt(1) == '9') {
                            System.out.println("PSAM read failed");
                            dialogbox("PSAM read failed");
                        }
                        else {
                            byte[] data = new byte[apduResponse.length];
                            for (i = 0; i < apduResponse.length; i++) {
                                if (apduResponse[i]==-1) {
                                    System.out.println("------>"+hexToString(apduResponse));
                                    s = new String(data, StandardCharsets.UTF_8);
                                    //System.out.println("-------->data:"+hexToString(data));
                                    System.out.println("PSAM read success");
                                    dialogbox(s);
                                    return;
                                }
                                data[i] = apduResponse[i];
                            }
                        }
                    } catch (DeviceException e) {
                        System.out.println("PSAM read failed");
                        e.printStackTrace();
                    }
                }
            }
        });
        noOfRecords.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                byte[] arryAPDU = new byte[] {
                        0x00, 0x22, 0x00, 0x00, 0x02
                };
                try {
                    byte[] apduResponse = ((CPUCard)psamCard).transmit(arryAPDU);
                    int records = apduResponse[1];
                    System.out.println("PSAM number of records success");
                    messageBox(String.valueOf(records));
                } catch (DeviceException e) {
                    System.out.println("PSAM number of records failed");
                    dialogbox("PSAM noOf records failed");
                    e.printStackTrace();
                }
            }
        });
        format.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                byte[] arryAPDU = new byte[] {
                        0x00, (byte) 0x9C, 0x00, 0x00, 0x00
                };
                try {
                    byte[] apduResponse = ((CPUCard)psamCard).transmit(arryAPDU);
                    String str = hexToString(apduResponse);
                    if(str.charAt(0) == '9' && str.charAt(1) == '0') {
                        System.out.println("PSAM format success");
                        dialogbox("PSAM Format success");
                    }
                    else {
                        System.out.println("PSAM format failed");
                        dialogbox("PSAM format failed");
                    }
                } catch (DeviceException e) {
                    System.out.println("PSAM format failed");
                    dialogbox("PSAM format failed");
                    e.printStackTrace();
                }
            }
        });
    }


    private String hexToString(byte[] t1) {
        System.out.println("hexToString is running");

        String strOut = new String("");
        for (int i = 0; i < t1.length; i++)
            strOut += String.format("%02X ", t1[i]);
        return strOut;
    }

    private void dialogbox(String msg) {
        System.out.println("dialogbox is running");
        AlertDialog.Builder alert = new AlertDialog.Builder(PSAM.this);
        alert.setTitle("PSAM");
        alert.setCancelable(false);
        alert.setMessage(msg);
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });
        alert.show();
    }
    private void messageBox(final String string) {
        System.out.println("messagebox is running");
        AlertDialog.Builder alert = new AlertDialog.Builder(PSAM.this);
        alert.setTitle("PSAM");
        alert.setMessage(string);
        alert.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                System.out.println("messagebox is running");
                // TODO Auto-generated method stub
                dialog.dismiss();
            }
        });
        alert.show();
    }
    private void buttonsColor(boolean enabled) {
        System.out.println("messagebox is running");
        read.setEnabled(enabled);
        write.setEnabled(enabled);
        noOfRecords.setEnabled(enabled);
        format.setEnabled(enabled);
        if (enabled) {
            read.setTextColor(getResources().getColor(R.color.colorAccent));
            write.setTextColor(getResources().getColor(R.color.colorAccent));
            noOfRecords.setTextColor(getResources().getColor(R.color.colorAccent));
            format.setTextColor(getResources().getColor(R.color.colorAccent));
        } else {
            read.setTextColor(getResources().getColor(R.color.colorPrimary));
            write.setTextColor(getResources().getColor(R.color.colorPrimary));
            noOfRecords.setTextColor(getResources().getColor(R.color.colorPrimary));
            format.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
    }
//    @Override
//    protected void onDestroy() {
//        super.onDestroy();
//        if(flag == 1) {
//            try {
//                ((SLE4442Card) psamCard).disconnect();
//            } catch (DeviceException e) {
//                e.printStackTrace();
//            }
//        }
//        if(flag==10){
//            try {
//                device.close();
//            } catch (DeviceException e) {
//                e.printStackTrace();
//            }
//        }
//    }

    @Override
    protected void onRestart() {
        System.out.println("********************onRestart");

        try {
            device.open();
        } catch (DeviceException e) {
            e.printStackTrace();
        }
        buttonsColor(false);
        cardPresence.setTextColor(getResources().getColor(R.color.colorAccent));
        cardPresence.setEnabled(true);
        super.onRestart();
    }

    @Override
    protected void onPause() {
        System.out.println("********************onPause");
        if(flag>0){
            try {
                ((SLE4442Card) psamCard).disconnect();
            } catch (DeviceException e) {
                e.printStackTrace();
            }
        }
        try {
            device.close();
            flag = 10;
        } catch (DeviceException e) {
            e.printStackTrace();
        }
        super.onPause();
    }

}