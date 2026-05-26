package com.visiontek.cloudpos_selfdiag;

import android.Manifest;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;


public class LCD extends AppCompatActivity implements View.OnClickListener {
    Button default_lcd;
    Button color;
    Button multiImages;
    Spinner images_types;
    public ImageView img;

    Activity context;
    //Seek bar object
    private SeekBar brightbar;

    //Variable to store brightness value
    private int brightness;
    //Content resolver used as a handle to the system's settings
    private ContentResolver cResolver;
    //Window object, that will store a reference to the current window
    private Window window;
    @RequiresApi(api = Build.VERSION_CODES.CUPCAKE)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.v("LCD", "onCreate");
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lcd);

        default_lcd= findViewById(R.id.default_lcd);
        color=findViewById(R.id.color);
        multiImages=findViewById(R.id.multImages);
        images_types= findViewById(R.id.spinner);
        img= findViewById(R.id.imageView1);


        default_lcd.setOnClickListener(this);
        color.setOnClickListener(this);
        multiImages.setOnClickListener(this);


        String[] items = new String[] { "PNG", "JPG", "GIF","BMP" };
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                android.R.layout.simple_spinner_dropdown_item, items);
        images_types.setAdapter(adapter);

        images_types.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> adapter, View v,
                                       int position, long id) {
                Log.v("LCD", "onItemSelected");

                String select_item = adapter.getItemAtPosition(position)
                        .toString();

                System.out.println("Selected item is " + select_item);
                if (select_item.equals("PNG")) {
                    //item_value = 20;
                    img.setImageResource(R.drawable.png);

                } else if (select_item.equals("JPG")) {
                    //item_value = 55;
                    img.setImageResource(R.drawable.jpg);
                } else if (select_item.equals("GIF")) {
                    //item_value = 71;
                    //img.setImageResource(R.drawable.skiing);

                    System.out.println("------------------------------->GIF");
                    Intent intent1 = new Intent(LCD.this, GIF.class);
                    intent1.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    startActivity(intent1);

                }else if(select_item.equals("BMP")){
                    img.setImageResource(R.drawable.bmp);
                }else {
                    //showToast("Default item Selected");
                    Toast.makeText(getApplicationContext(), "Nothing Selected", Toast.LENGTH_SHORT).show();
                }
                /*
                 * Toast.makeText(getApplicationContext(),
                 * "Selected Language is : " + select_item,
                 * Toast.LENGTH_LONG).show();
                 */
            }

            @Override
            public void onNothingSelected(AdapterView<?> arg0) {
                Log.v("LCD", "onNothingSelected");

                // TODO Auto-generated method stub

            }
        });

        float curBrightnessValue = 0;
        try {
            curBrightnessValue = android.provider.Settings.System.getInt(
                    getContentResolver(),
                    android.provider.Settings.System.SCREEN_BRIGHTNESS);
        } catch (Settings.SettingNotFoundException e) {
            e.printStackTrace();
        }


        //Instantiate seekbar object
        brightbar = (SeekBar) findViewById(R.id.seekBar1);


        //Get the content resolver
        cResolver = getContentResolver();

        //Get the current window
        window = getWindow();

        //Set the seekbar range between 0 and 255
        brightbar.setMax(255);
        //Set the seek bar progress to 1
        brightbar.setKeyProgressIncrement(1);


        //Set the progress of the seek bar based on the system's brightness
        brightbar.setProgress(brightness);

        //Register OnSeekBarChangeListener, so it can actually change values
        brightbar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener()
        {
            public void onStopTrackingTouch(SeekBar seekBar)
            {
                Log.v("LCD", "onStopTrackingTouch");

                System.out.println("onStopTrackingTouch is running");
                //Set the system brightness using the brightness variable value
                //System.putInt(cResolver, System.SCREEN_BRIGHTNESS, brightness);
                //Get the current window attributes
                ViewGroup.LayoutParams layoutpars = window.getAttributes();
                //Set the brightness of this window
                ((WindowManager.LayoutParams) layoutpars).screenBrightness = brightness / (float)255;
                //Apply attribute changes to this window
                window.setAttributes((WindowManager.LayoutParams) layoutpars);
            }

            public void onStartTrackingTouch(SeekBar seekBar)
            {
                Log.v("LCD", "onStartTrackingTouch");

                System.out.println("onStartTrackingTouch is running");

                //Nothing handled here
            }

            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser)
            {
                Log.v("LCD", "onProgressChanged");

                System.out.println("onProgressChanged is running");

                //Set the minimal brightness level
                //if seek bar is 20 or any value below
                if(progress<=20)
                {
                    //Set the brightness to 20
                    brightness=20;
                }
                else //brightness is greater than 20
                {
                    //Set brightness variable based on the progress bar
                    brightness = progress;
                }
                //Calculate the brightness percentage
                float perc = (brightness /(float)255)*100;
                //Set the brightness percentage
                // txtPerc.setText((int)perc +"%");
            }
        });


    }

    @Override
    public void onClick(View v) {
        Log.v("LCD", "onClick");

        System.out.println("onClick is running");
        // TODO Auto-generated method stub

        if(v.equals(default_lcd)){

            img.setImageResource(R.drawable.png);

        }else if(v.equals(color)){

            System.out.println("In Color");

            Intent intent = new Intent(this, Flash.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

            startActivity(intent);


        }else if(v.equals(multiImages)){

            Intent intent1 = new Intent(this, Test.class);
            intent1.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            startActivity(intent1);

        }

    }


    @TargetApi(Build.VERSION_CODES.M)
    public void setBrightness(View view,int brightness) {

        Log.v("LCD", "setBrightness");

        System.out.println("setBrightness is running");
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (Settings.System.canWrite(getApplicationContext())) {
                if (brightness < 46)
                    brightness = 255;
                else if (brightness > 47)
                    brightness = 0;

                ContentResolver cResolver = this.getApplicationContext().getContentResolver();
                Settings.System.putInt(cResolver, Settings.System.SCREEN_BRIGHTNESS, brightness);

            } else {
                Intent intent = new Intent(android.provider.Settings.ACTION_MANAGE_WRITE_SETTINGS);
                intent.setData(Uri.parse("package:" + this.getPackageName()));
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
            }
        }
    }

    public void youDesirePermissionCode(Activity context){
        Log.v("LCD", "youDesirePermissionCode");

        System.out.println("youDesirePermissionCode is running");
        boolean permission;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            permission = Settings.System.canWrite(context);
        } else {
            permission = ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_SETTINGS) == PackageManager.PERMISSION_GRANTED;
        }
        if (permission) {
            //do your code
        }  else {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS);
                intent.setData(Uri.parse("package:" + context.getPackageName()));
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivityForResult(intent, 100);
            } else {
                ActivityCompat.requestPermissions(context, new String[]{Manifest.permission.WRITE_SETTINGS}, 100);
            }
        }
    }
    @SuppressLint("NewApi")
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.v("LCD", "onActivityResult");

        System.out.println("onActivityResult is running");
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 100 && Settings.System.canWrite(this)){
            Log.d("TAG", "MainActivity.CODE_WRITE_SETTINGS_PERMISSION success");
            //do your code
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        Log.v("LCD", "onRequestPermissionsResult");

        System.out.println("onRequestPermissionsResult is running");
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 100 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            //do your code
        }
    }
}