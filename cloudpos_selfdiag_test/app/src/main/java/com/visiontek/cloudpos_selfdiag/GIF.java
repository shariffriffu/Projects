package com.visiontek.cloudpos_selfdiag;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class GIF extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.gif);
        GifImageView gifImageView =  findViewById(R.id.GifImageView);
        gifImageView.setGifImageResource(R.drawable.smartphone_drib);
    }
}