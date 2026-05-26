
package com.visiontek.cloudpos_selfdiag;


import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

import com.cloudpos.DeviceException;
import com.cloudpos.OperationListener;
import com.cloudpos.OperationResult;
import com.cloudpos.POSTerminal;
import com.cloudpos.TimeConstants;
import com.cloudpos.msr.MSRDevice;
import com.cloudpos.msr.MSROperationResult;
import com.cloudpos.msr.MSRTrackData;

import java.io.UnsupportedEncodingException;

public class Msr extends AppCompatActivity {
    int check=0;
    private MSRDevice device = null;
    public Button swipeCard;
    Context context;
     String jay= "Track Data:\n";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_msr);
        context = this;
        if (device == null) {
            device = (MSRDevice) POSTerminal.getInstance(context)
                    .getDevice("cloudpos.device.msr");
        }
        swipeCard = findViewById(R.id.swipe);

        try {
            device.open();
            System.out.println("msr open success");
            buttonTapColor(true);
        } catch (DeviceException e) {
            buttonTapColor(false);
            e.printStackTrace();
        }

        swipeCard.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");

                buttonTapColor(false);
                try {
                    OperationListener listener = new OperationListener() {

                        @Override
                        public void handleResult(OperationResult arg0) {
                            check=0;
                            if (arg0.getResultCode() == OperationResult.SUCCESS) {
                                MSRTrackData data = ((MSROperationResult) arg0).getMSRTrackData();
                                int trackError;
                                byte[] trackData;
                                jay= "Track Data:\n";
                                trackError = data.getTrackError(0);
                                if (trackError == MSRTrackData.NO_ERROR) {
                                    trackData = data.getTrackData(0);
                                    jay = jay + "Track" + 0 + ": " + hexToAscii(trackData) + "\n";
                                } else {
                                    jay = jay + "Track" + 0 + ": " + "null" + "\n";
                                    System.out.println(0 + "**********Error******" + trackError);
                                }
                                trackError = data.getTrackError(1);
                                if (trackError == MSRTrackData.NO_ERROR) {
                                    trackData = data.getTrackData(1);
                                    jay = jay + "Track" + 1 + ": " + hexToAscii(trackData) + "\n";
                                } else {
                                    jay = jay + "Track" + 1 + ": " + "null" + "\n";
                                    System.out.println(1 + "**********Error******" + trackError);
                                }
                                trackError = data.getTrackError(2);
                                if (trackError == MSRTrackData.NO_ERROR) {
                                    trackData = data.getTrackData(2);
                                    jay = jay + "Track" + 2 + ": " + hexToAscii(trackData) + "\n";
                                } else {
                                    jay = jay + "Track" + 2 + ": " + "null" + "\n";
                                    System.out.println(2 + "**********Error******" + trackError);
                                }
                                runOnUiThread(new Runnable() {
                                    @Override
                                    public void run() {
                                        dialogbox(jay,true);
                                    }
                                });

                                System.out.println("***********"+ (jay));
                            } else {
                                System.out.println("*******************FAIL");
                            }
                        }
                    };
                    device.listenForSwipe(listener, TimeConstants.FOREVER);
                    jay=null;
                } catch (DeviceException e) {
                    e.printStackTrace();
                }
            }

        });
    }

    private void dialogbox(String msg, final boolean btns) {
        System.out.println("dialogbox is running");


        AlertDialog.Builder alert = new AlertDialog.Builder(Msr.this);
        alert.setTitle("MSR");
        alert.setCancelable(false);
        alert.setMessage(msg);
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        if (btns) {
                            buttonTapColor(true);
                        }else {
                            buttonTapColor(false);
                        }

                    }
                });
        alert.show();
    }
    private String hexToAscii(byte[] t1){
        String utf = null;

        try {
            utf = new String(t1, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return utf;
    }
    private void buttonTapColor(boolean enabled) {
        System.out.println("buttonTapColor is running");
        swipeCard.setEnabled(enabled);
       if(enabled)
           swipeCard.setTextColor(getResources().getColor(R.color.colorAccent));
       else
           swipeCard.setTextColor(getResources().getColor(R.color.colorPrimary));
    }


    @Override
    protected void onRestart() {
        System.out.println("********************onRestart");
        try {
            device.open();
        } catch (DeviceException e) {
            e.printStackTrace();
        }
        super.onRestart();
    }

    @Override
    protected void onPause() {
        System.out.println("********************onPause");
        try {
            device.close();
        } catch (DeviceException e) {
            e.printStackTrace();
        }
        super.onPause();
    }
}