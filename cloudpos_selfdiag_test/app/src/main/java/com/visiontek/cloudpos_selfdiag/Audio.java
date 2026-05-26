package com.visiontek.cloudpos_selfdiag;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.View;
import android.widget.Button;

import java.io.IOException;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

public class Audio extends AppCompatActivity {

    private Button audio1Button,audio2Button,recorderButton;

    private static final int REQUEST_CODE_READ_EXTERNAL_PERMISSION = 2;
    MediaPlayer initaudioPlayer ;
    private Uri audioFileUri1;
    MediaPlayer audioPlayer;
    @SuppressLint("HandlerLeak")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_audio);
        recorderButton = findViewById(R.id.recorder_button);
        audio1Button = findViewById(R.id.play_audio1_button);
        audio2Button = findViewById(R.id.play_audio2_button);
        audioPlayer=null;
        initaudioPlayer=null;

        audio1Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
              int readExternalStoragePermission = ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.READ_EXTERNAL_STORAGE);
               if(readExternalStoragePermission != PackageManager.PERMISSION_GRANTED)
                              {
                    String[] requirePermission = {Manifest.permission.READ_EXTERNAL_STORAGE};
                    ActivityCompat.requestPermissions(Audio.this, requirePermission, REQUEST_CODE_READ_EXTERNAL_PERMISSION);
                }else {
                   test();
                   // AudioPlayer("/system/media/audio/notifications/DearDeer.ogg");
                   AudioPlayer("/system/media/audio/alarms/Alarm_Beep_01.ogg");
                }
            }
        });

        audio2Button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int readExternalStoragePermission = ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.READ_EXTERNAL_STORAGE);
                if(readExternalStoragePermission != PackageManager.PERMISSION_GRANTED) {
                    String[] requirePermission = {Manifest.permission.READ_EXTERNAL_STORAGE};
                    ActivityCompat.requestPermissions(Audio.this, requirePermission, REQUEST_CODE_READ_EXTERNAL_PERMISSION);
                }else {
                    test();
                    AudioPlayer("/system/media/audio/notifications/tweeters.ogg");
                }
            }
        });

        recorderButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialogbox();

            }
        });

    }

    private void dialogbox() {
        AlertDialog.Builder alert = new AlertDialog.Builder(Audio.this);
        alert.setTitle("Recorder");
        alert.setCancelable(false);
        alert.setMessage("Opening Sound Recorder application to record audio ");
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                        Intent recordIntent = new Intent(MediaStore.Audio.Media.RECORD_SOUND_ACTION);
                        recordIntent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        startActivityForResult(recordIntent, RESULT_OK);
                    }
                });
        alert.show();
    }


    private void AudioPlayer(String s) {
        try {
            if (audioPlayer == null) {
                audioPlayer = new MediaPlayer();
                audioFileUri1 = Uri.parse(s);
                System.out.println(audioFileUri1);
                audioPlayer.setDataSource(getApplicationContext(), audioFileUri1);
                audioPlayer.prepare();
                audioPlayer.start();
                audioPlayer.stop();

            }
        }
        catch(IOException ex){
                System.out.println("IO Exception = " + ex);
            }
        }

    /*private void initAudioPlayer() {
        try {
            if(initaudioPlayer == null) {
                System.out.println("***************4");
                initaudioPlayer = new MediaPlayer();
                audioFileUri1= Uri.parse("/system/media/audio/notifications/tweeters.ogg");
                System.out.println(audioFileUri1);
                initaudioPlayer.setDataSource(getApplicationContext(),audioFileUri1);
                initaudioPlayer.prepare();
                initaudioPlayer.start();
            }
        }catch(IOException ex) {
            System.out.println("IO Exception = "+ex);
        }

    }*/

    private void test() {
        if(audioPlayer !=null ) {
            if (audioPlayer.isPlaying()) {
                audioPlayer.stop();
            }
            audioPlayer.release();
            audioPlayer = null;
        }
        /*if (initaudioPlayer!=null ){
            System.out.println("***************2");
            if (initaudioPlayer.isPlaying()) {
                initaudioPlayer.stop();
            }
            initaudioPlayer.release();
            initaudioPlayer = null;
        }*/

   }

   /* @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        if (resultCode == Activity.RESULT_OK)
        {
            String theFilePath = data.getData().toString();
            System.out.println(theFilePath);
            test();
            AudioPlayer(theFilePath);
        }
    }*/

    @Override
    protected void onDestroy() {
       test();
        super.onDestroy();
    }
}
