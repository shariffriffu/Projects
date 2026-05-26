package com.visiontek.cloudpos_selfdiag;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.FileProvider;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.Set;

public class Bluetooth extends AppCompatActivity {
    Button mPairedBtn,mActivateBtn;
    int flag = 0;
    private BluetoothAdapter mBluetoothAdapter;
    TextView notifytxt, updatetxt, mStatusTv;
    public String sentResult;
    public String receiveResult;
    Set<BluetoothDevice> pairedDevices;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bluetooth);
        notifytxt =  findViewById(R.id.notifytxt);
        updatetxt =  findViewById(R.id.update);
        mStatusTv =  findViewById(R.id.tv_status);
        mActivateBtn =  findViewById(R.id.btn_enable);
        mPairedBtn =  findViewById(R.id.btn_view_paired);

     LocalBroadcastManager.getInstance(this).registerReceiver(onNotice, new IntentFilter("Msg"));

        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();

        File f= new File("/sdcard/","Draco.ogg");
        if (!f.exists()){

            copyFileOrDirectory("/system/media/audio/ringtones/Draco.ogg","/sdcard/");
            System.out.println(f);
        }

        if (mBluetoothAdapter == null) {
            buttonsColor(false);
        } else {
            mPairedBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    pairedDevices = mBluetoothAdapter.getBondedDevices();

                    try {
                        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) {//below version 6
                            pairedDevices = mBluetoothAdapter.getBondedDevices();
                            Intent intent = new Intent();
                            intent.setAction(Intent.ACTION_SEND);
                            intent.setType("audio/mp3");
                            String uri = "/sdcard/Draco.ogg";
                            intent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(new File(uri)));
                            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                            startActivity(intent);
                        } else {//storage/emulated/0/i_bt/a.mp3
                            try {
                                String uri = "/sdcard/Draco.ogg";
                                File file = new File(uri);
                                Uri photoUri = FileProvider.getUriForFile(getApplicationContext(), getApplicationContext().getPackageName() + ".provider", file);
                                pairedDevices = mBluetoothAdapter.getBondedDevices();
                                Intent intent = new Intent();
                                intent.setAction(Intent.ACTION_SEND);
                                intent.setType("audio/mp3");
                                intent.putExtra(Intent.EXTRA_STREAM,photoUri);
                                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                                startActivity(intent);
                            }
                            catch (Exception e){
                                e.printStackTrace();
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });

            mActivateBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    System.out.println("onclick is running");
                    if (mBluetoothAdapter.isEnabled()) {
                        mBluetoothAdapter.disable();
                        showDisabled();
                    }
                    else {

                        Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        startActivityForResult(intent, 1000);

                    }
                }
            });
            if (mBluetoothAdapter.isEnabled()) {
                buttonsColor(true);
            } else {
                showDisabled();
            }

        }

        IntentFilter filter = new IntentFilter();
        filter.addAction(BluetoothAdapter.ACTION_STATE_CHANGED);
        filter.addAction(BluetoothDevice.ACTION_FOUND);
        filter.addAction(BluetoothAdapter.ACTION_DISCOVERY_STARTED);
        filter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);

    }
    @Override
    public void onPause () {
        System.out.println("on pause in main activity");
        if (mBluetoothAdapter != null) {
            if (mBluetoothAdapter.isDiscovering()) {
                mBluetoothAdapter.cancelDiscovery();
            }
        }
        flag = 0;
        super.onPause();
    }
    private void showEnabled () {
        System.out.println("show enabled is running");
        mStatusTv.setText("Bluetooth is On");
        mStatusTv.setTextColor(Color.BLUE);
        mActivateBtn.setText("Disable");
        mActivateBtn.setEnabled(true);
        mPairedBtn.setEnabled(true);
        discover();
    }
    private void showDisabled () {
        System.out.println("show disabled is running");
        mStatusTv.setText("Bluetooth is Off");
        mStatusTv.setTextColor(Color.RED);
        mActivateBtn.setText("Enable");
        mActivateBtn.setEnabled(true);
        mActivateBtn.setTextColor(getResources().getColor(R.color.colorAccent));
        mPairedBtn.setEnabled(false);
        mPairedBtn.setTextColor(getResources().getColor(R.color.colorPrimary));
    }
    private void showUnsupported () {
        System.out.println("show unsupported is running");
        mStatusTv.setText("Bluetooth is unsupported by this device");
        mActivateBtn.setText("Enable");
        mActivateBtn.setEnabled(false);
        mPairedBtn.setEnabled(false);

    }

    private void buttonsColor(boolean enabled) {
        System.out.println("buttons color is running");
        mActivateBtn.setEnabled(enabled);
        mPairedBtn.setEnabled(enabled);
        if (enabled) {
            mStatusTv.setText("Bluetooth is On");
            mActivateBtn.setText("Disable");
            mStatusTv.setTextColor(Color.BLUE);
            mActivateBtn.setTextColor(getResources().getColor(R.color.colorAccent));
            mPairedBtn.setTextColor(getResources().getColor(R.color.colorAccent));
            discover();
        } else {
            mStatusTv.setText("Bluetooth is unsupported by this device");
            mActivateBtn.setText("Enable");
            mActivateBtn.setTextColor(getResources().getColor(R.color.colorPrimary));
            mPairedBtn.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
    }


    public void discover () {
        System.out.println("Discover is running");
        if (mBluetoothAdapter.getScanMode() != BluetoothAdapter.SCAN_MODE_CONNECTABLE_DISCOVERABLE) {
            Intent discoverableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
            discoverableIntent.putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION, 0);
            startActivityForResult(discoverableIntent, 50);
        }
    }
    @Override
    protected void onActivityResult ( int requestCode, int resultCode, Intent data){
        System.out.println("onActivityResult is running");
        try {
            super.onActivityResult(requestCode, resultCode, data);
            if (RESULT_OK == resultCode) {
                buttonsColor(true);

            }

            if (requestCode == 50) {

                if (mBluetoothAdapter.getScanMode() != BluetoothAdapter.SCAN_MODE_CONNECTABLE_DISCOVERABLE) {
                    finish();

                }
            }

            // if (requestCode == 1) {
            // enableNotify();
            // }
        } catch (Exception e) {
        }
    }
    private BroadcastReceiver onNotice = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {
            System.out.println("onReceive is running");
            // String pack = intent.getStringExtra("package");
            String title = intent.getStringExtra("title");
            String text = intent.getStringExtra("text");
            // int id = intent.getIntExtra("icon",0);

            Context remotePackageContext = null;
            try {
                if (title.contains("Bluetooth share: Sent files")) {
                    if (text.contains("1 successful, 0 unsuccessful")) {
                        updatetxt.setText("Send Test Completed");
                        sentResult = null;

                        notifytxt.setText(title + "\n" + text);

                        sentResult = notifytxt.getText().toString();

                        System.out.println(sentResult);

                    } else if (text.contains("0 successful, 1 unsuccessful")) {
                        updatetxt.setText("Send Test Completed");
                        sentResult = null;

                        notifytxt.setText(title + "\n" + text);

                        sentResult = notifytxt.getText().toString();

                        System.out.println(sentResult);

                    }
                } else if (title.contains("Bluetooth share: Received files")) {
                    if (text.contains("1 successful, 0 unsuccessful")) {
                        updatetxt.setText("Receive Test Completed");
                        receiveResult = null;

                        notifytxt.setText(title + "\n" + text);
                        receiveResult = notifytxt.getText().toString();

                        System.out.println(receiveResult);

                    } else if (text.contains("0 successful, 1 unsuccessful")) {
                        updatetxt.setText("Receive Test Completed");
                        receiveResult = null;

                        notifytxt.setText(title + "\n" + text);
                        receiveResult = notifytxt.getText().toString();

                        System.out.println(receiveResult);

                    }

                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    };


   public static void copyFileOrDirectory(String srcDir, String dstDir) {
        System.out.println("copyFileOrDirectory is running");
        try {
            File src = new File(srcDir);
            File dst = new File(dstDir, src.getName());

            if (src.isDirectory()) {

                String files[] = src.list();
                System.out.println(files);
                int filesLength = files.length;
                System.out.println(filesLength);
                for (int i = 0; i < filesLength; i++) {
                    String src1 = (new File(src, files[i]).getPath());
                    String dst1 = dst.getPath();
                    copyFileOrDirectory(src1, dst1);
                    System.out.println(src1);
                    System.out.println(dst1);

                }
            } else {
                copyFile(src, dst);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void copyFile(File sourceFile, File destFile) throws IOException {
        System.out.println("copyfile is running");
        if (!destFile.getParentFile().exists())
            destFile.getParentFile().mkdirs();

        if (!destFile.exists()) {
            destFile.createNewFile();
        }

        FileChannel source = null;
        FileChannel destination = null;

        try {
            source = new FileInputStream(sourceFile).getChannel();
            destination = new FileOutputStream(destFile).getChannel();
            destination.transferFrom(source, 0, source.size());
            System.out.println(destination);
        } finally {
            if (source != null) {
                source.close();
            }
            if (destination != null) {
                destination.close();
            }
        }
    }
}