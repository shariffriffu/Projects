package com.visiontek.cloudpos_selfdiag;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class IFD extends AppCompatActivity  {
    Context context;
    private Button PSAM, IFD;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ifd);
        context = this;
        IFD = findViewById(R.id.IFD);
        PSAM = findViewById(R.id.PSAM);

        IFD.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");
                Intent i = new Intent(context, SmartCard.class);
                i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(i);
            }
        });
        PSAM.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                System.out.println("onClick is running");
                Intent intent = new Intent(context, PSAM.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
            }
        });
    }
}