package com.visiontek.cloudpos_selfdiag;

import android.Manifest;
import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.telephony.CellInfo;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellSignalStrengthGsm;
import android.telephony.CellSignalStrengthLte;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.telephony.TelephonyManager;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;

  public class GPRS extends AppCompatActivity {
    String state,operator ,signal_strength,mode, data_status,iccid,imei,airplane_mode;

    public RecyclerView recyclerView;
    public CustomAdapter adapter;
    public List<DataModel> datalist;
    int PS, AC;
    public static final int REQUEST_READ_PHONE_STATE = 1;
    public static final int REQUEST_ACCESS_COARSE_LOCATION = 10;

    public FloatingActionButton fab;
    TelephonyManager telephonyManager;


    SubscriptionManager subscriptionManager;
    List<SubscriptionInfo> subscriptionInfoList;
    TelephonyInfo telephonyInfo;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        System.out.println("onCreate is running");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gprs);

        PS = ContextCompat.checkSelfPermission(this, android.Manifest.permission.READ_PHONE_STATE);
        AC = ContextCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_COARSE_LOCATION);

        if (PS != PackageManager.PERMISSION_GRANTED) {
            System.out.println("REQUESTING PHONE STATE PERMISSION");
            ActivityCompat.requestPermissions(GPRS.this, new String[]{android.Manifest.permission.READ_PHONE_STATE}, 1);
        } else if (AC !=PackageManager.PERMISSION_GRANTED){
            System.out.println("REQUESTING COARSE LOCATION PERMISSION");
            ActivityCompat.requestPermissions(GPRS.this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 10);
        }else {
            Display();
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    private void Display() {
        System.out.println("Display is running");
        recyclerView =  findViewById(R.id.recycler_view);
        datalist = new ArrayList<>();
        adapter = new CustomAdapter(this, datalist);
        RecyclerView.LayoutManager mLayoutManager = new GridLayoutManager(this, 1);
        recyclerView.setLayoutManager(mLayoutManager);
        recyclerView.setItemAnimator(new DefaultItemAnimator());
        recyclerView.setAdapter(adapter);
        System.out.println("View");

        get_method();
        prepareData();

//        fab =  findViewById(R.id.fab);
//        fab.setOnClickListener(new View.OnClickListener() {
//            @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
//            @Override
//            public void onClick(View view) {
//                System.out.println("REFRESH");
//                get_method();
//                prepareData();
//            }
//        });
    }

    private void prepareData() {
        System.out.println("prepareData is running");
        datalist.clear();
        DataModel a = new DataModel("Airplane Mode", airplane_mode , R.drawable.airplane_gprs);
        datalist.add(a);
       System.out.println("prepareData()"+a);


        a = new DataModel("Sim Cards", state, R.drawable.sim_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("Operator", operator, R.drawable.operator_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("Signal Strength", signal_strength, R.drawable.signal_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("Mode", mode, R.drawable.mode_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("Data Status", data_status, R.drawable.data_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("CCID ", iccid, R.drawable.iccid_grps);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        a = new DataModel("IMEI ", imei, R.drawable.imei_gprs);
        datalist.add(a);
        System.out.println("prepareData()"+a);


        adapter.notifyDataSetChanged();
    }

    @SuppressLint("SetTextI18n")
    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    private void get_method() {
        System.out.println("get_method is running");

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            System.out.println("get_method");
            return;
        }
        //MultiSimTelephonyManager multiSimTelephonyManager = new MultiSimTelephonyManager(this);
        telephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
        subscriptionManager = (SubscriptionManager) getSystemService(Context.TELEPHONY_SUBSCRIPTION_SERVICE);
        subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();
        telephonyInfo = TelephonyInfo.getInstance(this);
        state = null;
        operator = null;
        signal_strength = null;
        mode = null;
        data_status = null;
        iccid = null;
        imei = null;
        airplane_mode = null;
        state = get_state();
        System.out.println("DUAL SIM STATE == " + state);
        if (state.equals("No Sim")) {
            System.out.println("No Sims");
        } else {

            operator = get_Operator();
            System.out.println("DUAL SIM OPERATOR == " + operator);

            signal_strength = get_signal_mode(1);
            System.out.println("SINGLE SIM STRENGTH == " + signal_strength);

            mode = get_signal_mode(2);
            System.out.println("SINGLE SIM MODE == " + mode);

            iccid = get_Iccid();
            System.out.println("DUAL SIM ICCID == " + iccid);

        }

        data_status = data_connection();
        System.out.println("DATA CONNECTIVITY STATUS == " + data_status);


        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            imei = get_Imei();
            System.out.println("DUAL SIM IMEI == " + imei);
        }

        airplane_mode = get_Airplanemode();
        System.out.println("AIRPLANE MODE == " + airplane_mode);
    }

    private String get_state() {
        System.out.println("get_state is running");
        boolean isSIM1Ready = telephonyInfo.isSIM1Ready();
        boolean isSIM2Ready = telephonyInfo.isSIM2Ready();

        if (isSIM1Ready && isSIM2Ready) {

            return "Sim1 & Sim2";
        } else if (isSIM1Ready) {
            return "Sim1";
        } else if (isSIM2Ready) {
            return "Sim2";
        } else {
            return "No Sim";
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    private String get_Operator() {
        System.out.println("get_Operator is running");
        if (subscriptionInfoList != null && subscriptionInfoList.size() > 0) {
            StringBuffer Carrier = new StringBuffer();
            for (int i = 0; i < subscriptionInfoList.size(); i++) {
                SubscriptionInfo lsuSubscriptionInfo = subscriptionInfoList.get(i);
                Carrier.append(" ' ").append(lsuSubscriptionInfo.getDisplayName()).append(" ' ");

            }
            return String.valueOf(Carrier);
        }

        return null;
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    private String get_signal_mode(int select) {

        System.out.println("get_signal_mode is running");


        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            return null;
        }

        String signal_level = null;
        StringBuffer st=new StringBuffer();
        List<CellInfo> cellInfos = telephonyManager.getAllCellInfo();   //This will give i_info of all sims present inside your mobile
        if (cellInfos != null) {

            for (int i = 0; i < cellInfos.size(); i++) {

                if (!cellInfos.get(i).isRegistered()) {

                }else {
                    if (select==1){
                        if (cellInfos.get(i) instanceof CellInfoWcdma) {
                            CellInfoWcdma cellInfoWcdma = (CellInfoWcdma) telephonyManager.getAllCellInfo().get(i);
                            CellSignalStrengthWcdma cellSignalStrengthWcdma = cellInfoWcdma.getCellSignalStrength();
                            signal_level = cellSignalStrengthWcdma.getDbm()+" Dbm "+cellSignalStrengthWcdma.getAsuLevel()+" Asu ";
                            st.append(signal_level).append("\n");
                            System.out.println("CellInfoWcdma = " + st);
                        } else if (cellInfos.get(i) instanceof CellInfoGsm) {
                            CellInfoGsm cellInfogsm = (CellInfoGsm) telephonyManager.getAllCellInfo().get(i);
                            CellSignalStrengthGsm cellSignalStrengthGsm = cellInfogsm.getCellSignalStrength();
                            signal_level = cellSignalStrengthGsm.getDbm()+" Dbm "+cellSignalStrengthGsm.getAsuLevel()+" Asu ";
                            st.append(signal_level).append("\n");
                            System.out.println("CellInfoGsm = " + st);
                        } else if (cellInfos.get(i) instanceof CellInfoLte) {
                            CellInfoLte cellInfoLte = (CellInfoLte) telephonyManager.getAllCellInfo().get(i);
                            CellSignalStrengthLte cellSignalStrengthLte = cellInfoLte.getCellSignalStrength();
                            signal_level = cellSignalStrengthLte.getDbm()+" Dbm "+cellSignalStrengthLte.getAsuLevel()+" Asu ";
                            st.append(signal_level).append("\n");
                            System.out.println("CellInfoLte = " + st);
                        }
                    }else {
                        if (cellInfos.get(i) instanceof CellInfoWcdma) {
                            st.append(" 3G ").append("\n");
                        } else if (cellInfos.get(i) instanceof CellInfoGsm) {
                            st.append(" 2G ").append("\n");
                        } else if (cellInfos.get(i) instanceof CellInfoLte) {
                            st.append(" 4G ").append("\n");
                        }
                    }
                }
            }

        }

        return String.valueOf(st);
    }

    private String data_connection() {
        System.out.println("data_connection is running");
        // TODO Auto-generated method stub
        String datastate = null;
        int state = telephonyManager.getDataState();
        if (state == TelephonyManager.DATA_CONNECTED) {
            datastate = "Connected";
            return datastate;
        } else if (state == TelephonyManager.DATA_DISCONNECTED) {
            datastate = "DisConnected";
            return datastate;
        } else if (state == TelephonyManager.DATA_SUSPENDED) {
            datastate = "Suspended";
            return datastate;
        } else {
            datastate = "Connecting";
            return datastate;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    private String get_Iccid() {
        System.out.println("get_Iccid is running");
        if (subscriptionInfoList != null && subscriptionInfoList.size() > 0) {
            StringBuffer Iccid = new StringBuffer();
            for (int i = 0; i < subscriptionInfoList.size(); i++) {
                SubscriptionInfo lsuSubscriptionInfo = subscriptionInfoList.get(i);
                Iccid.append(lsuSubscriptionInfo.getIccId()).append("\n");
            }
            return String.valueOf(Iccid);
        }
        return null;
    }

    @SuppressLint("HardwareIds")
    @RequiresApi(api = Build.VERSION_CODES.O)
    private String get_Imei() {
        System.out.println("get_Imei is running");
        String imei = null;
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            return null;
        }
//        String sim1_imei = telephonyManager.getDeviceId(0);
//        String sim2_imei= telephonyManager.getDeviceId(1);
        String sim1_imei = telephonyManager.getImei(0);
        String sim2_imei = telephonyManager.getImei(1);
        imei=sim1_imei+"\n"+sim2_imei;
        return imei;
    }

    private String get_Airplanemode() {

        String mode;
        boolean isEnabled = Settings.System.getInt(
                getContentResolver(),
                Settings.System.AIRPLANE_MODE_ON, 0) == 1;
        System.out.println("get_Airplanemode is running");

        if (isEnabled){
            mode="Enabled";
            return mode;
        } else {
            mode="Disabled";
            return mode;
        }

    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP_MR1)
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String permissions[], @NonNull int[] grantResults) {
        switch (requestCode) {
            case REQUEST_READ_PHONE_STATE:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        if (AC != PackageManager.PERMISSION_GRANTED) {
                            ActivityCompat.requestPermissions(GPRS.this, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION}, 10);
                        }else {
                            Display();
                        }
                    }
                }else {
                    dialogBox("Permission","Please allow these permissions in order to use application");
                }
                break;

            case REQUEST_ACCESS_COARSE_LOCATION:
                if ((grantResults.length > 0) && (grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    Display();
                }else {
                    dialogBox("Permission","Please allow these permissions in order to use application");
                }
                break;
            default:
                break;
        }
    }
    public void dialogBox(String st, String msg) {
        System.out.println("dialogBox is running");
        AlertDialog.Builder alert = new AlertDialog.Builder(this);
        alert.setTitle(st);
        alert.setCancelable(false);
        alert.setMessage(msg);
        DialogInterface.OnClickListener listener;
        alert.setPositiveButton("OK",
                new DialogInterface.OnClickListener() {

                    @Override
                    public void onClick(DialogInterface dialog,
                                        int which) {
                        dialog.dismiss();
                        finish();
                    }
                });
        alert.show();
    }

}