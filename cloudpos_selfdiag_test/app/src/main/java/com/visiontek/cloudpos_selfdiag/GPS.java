package com.visiontek.cloudpos_selfdiag;

import android.Manifest;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

public class GPS extends AppCompatActivity {
    private static final int REQUEST_ACCESS_FINE_LOCATION = 10, REQUEST_ACCESS_COARSE_LOCATION = 11;
    TextView tv1;
    int CL, FL;
    LocationManager locationManager;
    Button get_GPS;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.v("GPS", "onCreate");
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gps);
        final Context context = this;
        tv1 = findViewById(R.id.TextView02);
        get_GPS = findViewById(R.id.gps);
        get_GPS.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");
                tv1.setText("");
                if (getLocationMode(context) == 3) {
                    get_GPS.setEnabled(false);
                    get_GPS.setTextColor(getResources().getColor(R.color.colorPrimary));
                    Display();
                } else {
                    dialogbox();
                }

            }
        });
    }

    private void Display() {
        Log.v("GPS", "Display");
     //   System.out.println("Display is running");
        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        boolean st = getLocation();
        System.out.println("LOCATION = " + st);
        if (!st) {
            statusCheck();
        }

        LocationListener locationListener = new GPS.MyLocationListener();
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, 0, locationListener);
       locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 1000, 0, locationListener);
/*
locationManager.requestLocationUpdates(locationManager.PROVIDERS_CHANGED_ACTION, 1000, 0,locationListener);
*/
    }

    public void statusCheck() {
        Log.v("GPS", "statusCheck");
        System.out.println("statusCheck is running");
        final LocationManager manager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        if (!manager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            buildAlertMessageNoGps();

        }
    }

    private void buildAlertMessageNoGps() {
        Log.v("GPS", "buildAlertMessageNoGps");
        System.out.println("buildAlertMessageNoGps is running");
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("Your GPS seems to be disabled, do you want to enable it?")
                .setCancelable(false)
                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        startActivity(new Intent(android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS));
                    }
                })
                .setNegativeButton("No", new DialogInterface.OnClickListener() {
                    public void onClick(final DialogInterface dialog, final int id) {
                        dialog.cancel();
                    }
                });
        final AlertDialog alert = builder.create();
        alert.show();
    }

    private boolean getLocation() {
        Log.v("GPS", "getLocation");
        System.out.println("getLocation is running");
        int locationMode = 0;
        String locationProviders;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            try {
                locationMode = Settings.Secure.getInt(getContentResolver(), Settings.Secure.LOCATION_MODE);

            } catch (Settings.SettingNotFoundException e) {
                e.printStackTrace();
                return false;
            }

            return locationMode != Settings.Secure.LOCATION_MODE_OFF;

        } else {
            locationProviders = Settings.Secure.getString(getContentResolver(), Settings.Secure.LOCATION_PROVIDERS_ALLOWED);
            return !TextUtils.isEmpty(locationProviders);
        }
    }

    private class MyLocationListener implements LocationListener {

        @Override
        public void onLocationChanged(Location loc) {
            Log.v("GPS", "onLocationChanged");
            System.out.println("onLocationChanged is running");
            String longitude = "Longitude: " + loc.getLongitude();
            System.out.println("-------------------" + longitude);
            String latitude = "Latitude: " + loc.getLatitude();
            System.out.println("-------------------" + latitude);
            String s = longitude + "\n" + latitude;
            tv1.setText(s);
            locationManager.removeUpdates(this);
            locationManager = null;
            get_GPS.setEnabled(true);
            get_GPS.setTextColor(getResources().getColor(R.color.colorAccent));

        }

        @Override
        public void onProviderDisabled(String provider) {
            Log.v("GPS", "onProviderDisabled");

            System.out.println("*********Disabled");
        }

        @Override
        public void onProviderEnabled(String provider) {

            Log.v("GPS", "onProviderEnabled");
            System.out.println("*********Enabled");
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {
            Log.v("GPS", "onStatusChanged");
            System.out.println("*********Status Changed");
        }
    }
    public int getLocationMode(Context context) {
        Log.v("GPS", "getLocationMode");

        System.out.println("*********getLocationMode");
        try {
          return Settings.Secure.getInt(context.getContentResolver(), Settings.Secure.LOCATION_MODE);


        } catch (Settings.SettingNotFoundException e) {
            e.printStackTrace();
            return -1;
        }
    }
    private void dialogbox() {
        Log.v("GPS", "dialogbox");
        System.out.println("dialogbox is running");
        AlertDialog.Builder alert = new AlertDialog.Builder(GPS.this);
        alert.setTitle("GPS");
        alert.setCancelable(false);
        alert.setMessage("Please Turn On GPS to High Accuracy Mode");
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        startActivity(new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS));
                    }
                });
        alert.show();
    }
}