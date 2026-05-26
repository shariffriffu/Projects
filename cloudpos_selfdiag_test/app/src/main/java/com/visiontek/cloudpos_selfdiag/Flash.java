package com.visiontek.cloudpos_selfdiag;

import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.RelativeLayout;

import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import androidx.appcompat.app.AppCompatActivity;

public class Flash extends AppCompatActivity {
    RelativeLayout relativeLayout;

    int i;

    int colors[] = { Color.WHITE,Color.RED,Color.GREEN,Color.BLUE,Color.YELLOW,
            Color.MAGENTA ,Color.CYAN };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.colors);
        relativeLayout = (RelativeLayout) findViewById(R.id.mylayout);

        //relativeLayout.setBackgroundResource(images[getRandomNumber()]);
        //relativeLayout.setBackgroundColor(colors[i]);

        Timer myTimer;
        myTimer = new Timer();
        myTimer.schedule(new TimerTask() {

            @Override
            public void run() {

                System.out.println("The i value" + i);
                // TimerMethod();
                if (i == 6) {
                    finish();
                    cancel();
                }

                else
                    new CustomTask().execute((Void[]) null);

            }
        }, 0, 1000);

        System.out.println("After Timer");

    }

    private class CustomTask extends AsyncTask<Void, Void, Void> {

        protected Void doInBackground(Void... param) {
            // Do some work

            i++;
            return null;
        }

        protected void onPostExecute(Void param) {
            // Print Toast or open dialog

            relativeLayout.setBackgroundColor(colors[i]);


        }
    }

    private int getRandomNumber() {
        // Note that general syntax is Random().nextInt(n)
        // It results in range 0-4
        // So it should be equal to number of images in images[] array
        return new Random().nextInt(5);
    }

}