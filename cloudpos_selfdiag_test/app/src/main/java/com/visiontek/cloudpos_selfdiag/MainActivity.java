package com.visiontek.cloudpos_selfdiag;

import android.Manifest;
import android.app.AlertDialog;
import android.app.DownloadManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;


public class MainActivity extends AppCompatActivity {
  private static final String TAG = "cloudpos VA 21";
    private static final int REQUEST_CAMERA = 10;
    private static final int REQUEST_ACCESS_FINE_LOCATION = 40;
    private static final int REQUEST_ACCESS_COARSE_LOCATION = 50;
    private static final int REQUEST_STORAGE_READ_SDCARD_open = 80;
    private static final int REQUEST_STORAGE_WRITE_SDCARD_open = 90;


    private static final int R_CAM = 1;
    private static final int R_GPS = 4;
    private static final boolean TODO = false;




    ComponentName cn;
    Intent intent;
    Context context;
    String error_check;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Log.i(TAG, "Main : onCreate");

        context = this;
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_STORAGE_READ_SDCARD_open);
        Log.i(TAG, "Main : onCreate : READ Req permissions ");
        toast("selfdiagapplication");
    }

    private void toast(String msg) {
        Toast.makeText(context, msg, Toast.LENGTH_SHORT).show();
        System.out.println("Toast message");
    }

    @RequiresApi(api = Build.VERSION_CODES.M)

    public void onButtonClick(View v) {
        switch (v.getId()) {

            case R.id.main_btn_audio:
                Log.d(TAG, "Main : onButtonClick : Audio Clicked ");
                intent = new Intent(this, Audio.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
                break;

            case R.id.main_btn_lcd:
                Log.d(TAG, "Main : onButtonClick : LCD Clicked ");
                intent = new Intent(this, LCD.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
                break;

            case R.id.main_btn_bluetooth:
                Log.d(TAG, "Main : onButtonClick : Bluetooth Clicked ");
                intent = new Intent(this, Bluetooth.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                startActivity(intent);

                break;

            case R.id.main_btn_camera:
                Log.d(TAG, "Main : onButtonClick : Camera Clicked ");
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.CAMERA}, REQUEST_CAMERA);
                Log.d(TAG, "Main : onButtonClick : Camera permissions Req");
                break;

            case R.id.main_btn_gps:
                Log.d(TAG, "Main : onButtonClick : GPS Clicked ");
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_ACCESS_FINE_LOCATION);
                break;

            case R.id.main_btn_sdcard:
                Log.d(TAG, "Main : onButtonClick : SDcard Clicked ");
                startActivity(new Intent(DownloadManager.ACTION_VIEW_DOWNLOADS));

                break;

            case R.id.main_btn_gprs:
                Log.d(TAG, "Main : onButtonClick : GPRS Clicked ");
                intent = new Intent(this, GPRS.class);
                startActivity(intent);

                break;

            case R.id.main_btn_wifi:
                Log.d(TAG, "Main : onButtonClick : WIFI Clicked ");
                intent = new Intent(Intent.ACTION_MAIN, null);
                intent.addCategory(Intent.CATEGORY_LAUNCHER);
                cn = new ComponentName("com.android.settings", "com.android.settings.wifi.WifiSettings");
                intent.setComponent(cn);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);

                break;

            case R.id.main_btn_fp:
                Log.d(TAG, "Main : onButtonClick : FPS Clicked ");
                intent = new Intent(this, SampleActivity.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                startActivity(intent);
                break;

            case R.id.main_btn_info:
                Log.i(TAG, "Main : onButtonClick : Info Clicked ");
               StringBuffer value = getInfo();
               String k = String.valueOf(value);
                dialogBox("Device Info", k);
                break;

            case R.id.main_btn_printer:
                Log.d(TAG, "Main : onButtonClick : Printer Clicked ");
                intent = new Intent(this, Printer.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                Log.d(TAG, "Main : onButtonClick : Buzzer Clicked ");

                startActivity(intent);
                break;

            case R.id.main_btn_rfid:
                Log.d(TAG, "Main : onButtonClick : RFID Clicked ");
                intent = new Intent(this, Rfid.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                startActivity(intent);
                break;

            case R.id.main_btn_msr:
                Log.d(TAG, "Main : onButtonClick : MSR Clicked ");
                intent = new Intent(this, Msr.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                startActivity(intent);
                break;

            case R.id.main_btn_ifd:
                Log.d(TAG, "Main : onButtonClick : IFD Clicked ");
                intent = new Intent(MainActivity.this, IFD.class);

                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

                startActivity(intent);
                break;

            case R.id.main_btn_battery:
                Log.d(TAG, "Main : onButtonClick : Battery Clicked ");
                StringBuffer val = getBatteryInfo();
                String st = String.valueOf(val);
                dialogBox("Battery Info", st);
                break;


            case R.id.main_btn_usb:
                Log.d(TAG, "Main : onButtonClick : USB Clicked ");
                startActivity(new Intent(DownloadManager.ACTION_VIEW_DOWNLOADS));
                Toast.makeText(context, "Please wait until jetflash to complete", Toast.LENGTH_SHORT).show();
            default:
                break;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    public StringBuffer getInfo()
    {
        StringBuffer data = new StringBuffer();

      data.append("Kernel v: ").append(readKernelVersion());
        data.append("\n\nBase band v: ").append(Build.getRadioVersion());
        data.append("\n\nModel: ").append(Build.BOARD);
        data.append("\n\nBuild No: ").append(Build.DISPLAY);
        data.append("\n\nSecurity Patch: ").append(Build.VERSION.SECURITY_PATCH);
        data.append("\n\nAndroid v: ").append(Build.VERSION.RELEASE);
        data.append("\n\nSerial NO: ").append(Build.SERIAL);
        return data;
    }
    public static String readKernelVersion() {
       try {
            Process p = Runtime.getRuntime().exec("uname -a");
            InputStream is = null;
            if (p.waitFor() == 0) {
                is = p.getInputStream();
            } else {
                is = p.getErrorStream();
            }
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            String line = br.readLine();
            br.close();
            return line;
        } catch (Exception ex) {
            Log.d(TAG, "Main : readKernelVersion : Exception : " + ex);
            return "ERROR: " + ex.getMessage();
        }
    }

   /* public float getBatteryInfo()
    {   IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = getApplicationContext().registerReceiver(null, ifilter);
        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        float batteryPct = level / (float)scale;
        float p = batteryPct * 100;
        StringBuffer sb = new StringBuffer();
        Log.d("Battery percentage",String.valueOf(Math.round(p)));
        return p;
         }*/

    public StringBuffer getBatteryInfo() {
       IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        Intent batteryStatus = this.registerReceiver(null, ifilter);
        assert batteryStatus != null;
        int status = batteryStatus.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
        boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL;
        int chargePlug = batteryStatus.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1);
        boolean usbCharge = chargePlug == BatteryManager.BATTERY_PLUGGED_USB;
        boolean acCharge = chargePlug == BatteryManager.BATTERY_PLUGGED_AC;
        int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        float batteryPct = level / (float) scale;
        StringBuffer data = new StringBuffer();
        if(isCharging==false)
            data.append("Charging Status: ").append("Discharging");
        else
            data.append("Charging Status: ").append("Charging");
        if(usbCharge==false)
            data.append("\nCharging over USB: ").append("No");
        else
            data.append("\nCharging over USB: ").append("Yes");
        if(acCharge==false)
            data.append("\n Charging over AC: ").append("No");
        else
            data.append("\nCharging over AC: ").append("Yes");

        data.append("\nBattery : ").append((int)(batteryPct * 100)).append('%');
        return data;
    }

    private void Camera() {
        Intent i = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
        try {
            PackageManager pm = MainActivity.this.getPackageManager();

            final ResolveInfo mInfo = pm.resolveActivity(i, 0);

            Intent intent2 = new Intent();

            intent2.setComponent(new ComponentName(mInfo.activityInfo.packageName, mInfo.activityInfo.name));

            intent2.setAction(Intent.ACTION_MAIN);

           intent2.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

           intent2.addCategory(Intent.CATEGORY_LAUNCHER);
           startActivityForResult(intent2, R_CAM);
        } catch (Exception e) {
            Log.d(TAG, "Main : Camera : Exception : " + e);
        }
    }
    public void dialogBox(String st, String msg) {
        Log.d(TAG, "Main : dialogBox : " + st + " : " + " msg ");
        AlertDialog.Builder alert = new AlertDialog.Builder(this);
        alert.setTitle(st);
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

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String permissions[], @NonNull int[] grantResults) {
        switch (requestCode) {
            case REQUEST_CAMERA:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        Log.d(TAG, "Main : onRequestPermissionsResult : Camera Req permissions Granted ");
                        Camera();
                    }
                } else {
                    Log.d(TAG, "Main : onRequestPermissionsResult : Camera Req permissions Denied ");
                    dialogBox("Permissions", "Please allow these permissions in order to use application");
                }
                break;
            case REQUEST_ACCESS_FINE_LOCATION:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        Log.d(TAG, "Main : onRequestPermissionsResult : ACCESS_FINE Location Req permissions Granted ");
                        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, REQUEST_ACCESS_COARSE_LOCATION);
                        Log.d(TAG, "Main : onRequestPermissionsResult : ACCESS_COARSE Req Location permissions ");
                    }
                } else {
                    Log.d(TAG, "Main : onRequestPermissionsResult : ACCESS_FINE Req permissions Denied ");
                    dialogBox("Permissions", "Please allow these permissions in order to use application");
                }
                break;
            case REQUEST_ACCESS_COARSE_LOCATION:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        Log.d(TAG, "Main : onRequestPermissionsResult : ACCESS_COARSE Req permissions Granted");
                        intent = new Intent(this, GPS.class);

                        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        startActivityForResult(intent, R_GPS);
                    }
                } else {
                    Log.d(TAG, "Main : onRequestPermissionsResult : ACCESS_COARSE Req permissions Denied ");
                    dialogBox("Permissions", "Please allow these permissions in order to use application");
                }
                break;
            case REQUEST_STORAGE_READ_SDCARD_open:
                if (((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED))) {
                    Log.d(TAG, "Main : onRequestPermissionsResult : READ Req permissions Granted ");
                    ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, REQUEST_STORAGE_WRITE_SDCARD_open);
                    Log.d(TAG, "Main : onRequestPermissionsResult : WRITE Req permissions ");
                } else {
                    Log.d(TAG, "Main : onRequestPermissionsResult : READ Req permissions Denied");
                    finish();
                }
                break;
            case REQUEST_STORAGE_WRITE_SDCARD_open:
                if (((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED))) {
                    Log.d(TAG, "Main : onRequestPermissionsResult : WRITE Req permissions Granted");
                } else {
                    Log.d(TAG, "Main : onRequestPermissionsResult : WRITE Req permissions Denied");
                    finish();
                }
            default:
                break;
        }
    }
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);


        Log.d("Focus debug", "Focus changed !");

        if (!hasFocus) {
            Log.d("Focus debug", "Lost focus !");

            Intent closeDialog = new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
            sendBroadcast(closeDialog);
        }
    }
}
