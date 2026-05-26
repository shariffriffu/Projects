package com.cloudpos.convertdifffinger;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import com.cloudpos.printer.PrinterDevice;
import com.cloudpos.printer.Format;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.cloudpos.DeviceException;
import com.cloudpos.POSTerminal;
import com.cloudpos.convertdifffinger.mgr.FPMgrImpl;
import com.cloudpos.convertdifffinger.mgr.IFPMgr;
import com.cloudpos.convertdifffinger.utils.HexString;
import com.cloudpos.fingerprint.Fingerprint;
import com.cloudpos.fingerprint.FingerprintDevice;
import com.digitalpersona.uareu.Engine;
import com.digitalpersona.uareu.Fmd;
import com.digitalpersona.uareu.Importer;
import com.digitalpersona.uareu.UareUException;
import com.digitalpersona.uareu.UareUGlobal;
import com.upek.android.ptapi.PtConstants;
import com.upek.android.ptapi.PtException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.lang.reflect.Method;
import java.util.Locale;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {


    private static final String ANDROID_CHANNEL = "com.cloudpos.convertdifffinger/convertdifffinger";
    private String deviceType;
    private Importer mImporter;
    private Engine mEngine;
    private MethodChannel mChannel;
    private FingerprintDevice device = null;
    private PrinterDevice mdevice = (PrinterDevice) POSTerminal.getInstance(MainActivity.this).getDevice("cloudpos.device.printer");  
    protected Handler mHandler;
    private Format format = new Format();
    
   
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        mChannel = new MethodChannel(flutterEngine.getDartExecutor(), ANDROID_CHANNEL);
        mChannel.setMethodCallHandler(this);


    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        init();
    }

    //设置回调函数
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "checkDeviceType":
                result.success(deviceType);
                break;

        
            case "sendData":
                new Thread(() -> {
                    if (deviceType.contains("tuzhengbig")) {
                        mInvokeTuzheng();
                    } else if (deviceType.toLowerCase(Locale.ROOT).contains("crossmatch")) {
                        mInvokeCrossmatch();
                    }
                }).start();
                break;
            case "verify":

                IFPMgr fpMgr = FPMgrImpl.getInstance();     
                boolean fing = fpMgr.verifyAll(this);  // Using 'var' if supported, or specify the actual type
                writerLogInTextview("============================================="+fing , 1);

                if (fing == true) {
                    writerLogInTextview("finger verified successfully" , 1);

                } else {
                    writerLogInTextview("Finger is not maching", 1);
                }

                break;
          
                case "verifyFing":

                IFPMgr fpMgrr = FPMgrImpl.getInstance();     
                boolean fingg = fpMgrr.verifyAll(this);  // Using 'var' if supported, or specify the actual type
                writerLogInTextview("============================================="+fingg , 1);

                if (fingg == true) {
                    writerLogInTextview("password finger successfully" , 1);

                } else {
                    writerLogInTextview("password finger is not maching", 1);
                }

                break;
          
                case "print":
                try {
                    String message = call.argument("message");
                    if (message != null) {
                        mdevice.open(); //opening printer device
                        // format.setParameter("size", "large");
                        mdevice.printlnText(format, message);
                        mdevice.close();
                    }
                } catch (DeviceException e) {
                    // Handle the exception here, such as logging or displaying an error message
                    e.printStackTrace(); // This is just for demonstration, replace it with appropriate error handling
                }
            
                break;  
                case "add":
                try {
                    writerLogInTextview("insert finger", 1);

                    int count = call.argument("fingercount");
                    writerLogInTextview(String.format("insert finger %d", count), 1);
                    
                    fpMgr = FPMgrImpl.getInstance();
                    String str=fpMgr.test(MainActivity.this, 1);
                    System.out.println("*******hi ****" + str);
                   
                    writerLogInTextview(str, 1);
                  
                    
                   
                } catch (Exception e) {
                    writerLogInTextview(e.getMessage(), 2);
                }
                break;
                case "addsingle":
                try {

                   
                    fpMgr = FPMgrImpl.getInstance();
                    String str=fpMgr.test(MainActivity.this, 1);
                   
                    writerLogInTextview(str, 1);
                  
                    
                   
                } catch (Exception e) {
                    writerLogInTextview(e.getMessage(), 2);
                }
                break;    
                case "deleteData":

                int id = call.argument("id");
                fpMgr = FPMgrImpl.getInstance();
               String del =fpMgr.deleteFinger(MainActivity.this, id);
               System.out.println("*******1111****" + del);
               writerLogInTextview(del, 1);                       

                break;
               
                case "list":
                try {
                    System.out.println("*******1111****" );

                    fpMgr = FPMgrImpl.getInstance();
                 String llist=   fpMgr.listAllFingers(MainActivity.this);
                    System.out.println("*******22222****"+llist);
                    writerLogInTextview(" The count of finger is:"+llist, 1);                       
                          
    
                    if(llist.equals("enrollFp failed! reason: check fingerprint failed!")){
                            
                                     writerLogInTextview("enrollFp failed! reason: check fingerprint failed!", 1);
                                  
                         }else{
                            writerLogInTextview(" The count of finger is:" + llist, 1);                              
                           }
                                
                    
                    
                   
                } catch (Exception e) {
                    writerLogInTextview(e.getMessage(), 2);
                }
                
                break;  
                case "deleteAll":
                fpMgr = FPMgrImpl.getInstance();
                fpMgr.deleteAllFingerData(MainActivity.this);
                break;
              
                
     default:
                result.notImplemented();
                break;
        }
    }

    private void writerLogInTextview(String log, int id) {
        Message msg = new Message();
        msg.what = id;
        msg.obj = log;
        mHandler.sendMessage(msg);
    }

    
    @SuppressLint("HandlerLeak")
    private void init() {
        mHandler = new Handler() {
            @Override
            public void handleMessage(Message msg) {
                String str = msg.obj + "\n";
                if (msg.what == 0) {
                    mChannel.invokeMethod("getDataNomal", msg.obj);
                } else if (msg.what == 1) {
                    mChannel.invokeMethod("getDataSuccess", msg.obj);
                } else if (msg.what == 2) {
                    mChannel.invokeMethod("getDataFail", msg.obj);
                }
            }
        };
        try {
            mImporter = UareUGlobal.GetImporter();
            mEngine = UareUGlobal.GetEngine();
        } catch (Exception e) {
            e.printStackTrace();
        }
        deviceType = checkDeviceType();
        if (deviceType.contains("tuzhengbig")) {
            //ready FingerprintDevice
            new Thread(() -> {
                if (device == null) {
                    device = (FingerprintDevice) POSTerminal.getInstance(this).getDevice("cloudpos.device.fingerprint");
                }
                try {
                    device.open(1);
                    writerLogInTextview("device.open success!", 1);
                } catch (DeviceException e) {
                    writerLogInTextview("device.open failed!", 2);
                    e.printStackTrace();
                }
            }).start();
        }
    }

    
    private void mInvokeCrossmatch() {

        byte[] crossmatchBs = getcrossmatchData();
        if (crossmatchBs == null) {
            Log.d("ConvertDiffFinger", "not get crossmatch fingerprint");
            writerLogInTextview("not get crossmatch fingerprint", 2);
            return;
        }
        try {
            //Convert the acquired data into an FMD object,format is ANSI_378_2004;
            Fmd fmCROSSMATCH_ANSI = mImporter.ImportFmd(crossmatchBs, Fmd.Format.ANSI_378_2004, Fmd.Format.ANSI_378_2004);
            writerLogInTextview("fmCROSSMATCH_ANSI finger import ok!", 1);
            Log.e("fp", "" + HexString.bufferToHex(fmCROSSMATCH_ANSI.getData()));

            //Convert the acquired data into an FMD object,format is ISO_19794_2_2005;
            Fmd CROSSMATCH_ANSI_TO_ISO = mImporter.ImportFmd(crossmatchBs, Fmd.Format.ANSI_378_2004, Fmd.Format.ISO_19794_2_2005);
            Log.e("fp", "" + HexString.bufferToHex(CROSSMATCH_ANSI_TO_ISO.getData()));
            writerLogInTextview("fmCROSSMATCH_ANSI_TO_ISO finger ok!", 1);

            // use crossmatch sdk : "engine.Compare"
            /*
             * Compare
             * int Compare(Fmd fmd1,
             *           int view_index1,
             *           Fmd fmd2,
             *           int view_index2)
             *           throws UareUException
             * Compares two fingerprints.
             * Given two single views from two FMDs, this function returns a dissimilarity score indicating the quality of the match. The dissimilarity scores returned values are between: 0=match PROBABILITY_ONE=no match Values close to 0 indicate very close matches, values closer to PROBABILITY_ONE indicate very poor matches. For a discussion of how to evaluate dissimilarity scores, as well as the statistical validity of the dissimilarity score and error rates, consult the Developer Guide.
             *
             * Parameters:
             * fmd1 - First FMD.
             * view_index1 - Index of the view in the first FMD.
             * fmd2 - Second FMD.
             * view_index2 - Index of the view in the second FMD.
             * Returns:
             * Dissimilarity score.
             * Throws:
             * UareUException - if failed to perform comparison.
             * */

            //The parameter is the fmd object converted above.
            int score = mEngine.Compare(fmCROSSMATCH_ANSI, 0, CROSSMATCH_ANSI_TO_ISO, 0);
            //  int score = mEngine.compareByFormat(fmCROSSMATCH_ANSI, 0, CROSSMATCH_ANSI_TO_ISO, 1);

            //compare myself, score: 0=match
            if (score == 0) {
                writerLogInTextview("Compare fmCROSSMATCH_ANSI and CROSSMATCH_ANSI_TO_ISO fingerprint success!", 1);
            } else {
                writerLogInTextview("Compare fmCROSSMATCH_ANSI and CROSSMATCH_ANSI_TO_ISO fingerprint failed!", 2);
            }

            Log.i("ConvertDiffFinger", String.format("mEngine.Compare,score = %d", score));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void mInvokeTuzheng() {
        writerLogInTextview("press your finger!", 0);

        //1,get Tuzheng fingerprint Data
        byte[] tuzhengBs = getTuzhengData();
        if (tuzhengBs == null) {
            Log.d("ConvertDiffFinger", "not get tuzheng fingerprint");
            writerLogInTextview("not get tuzheng fingerprint", 2);
            return;
        }
        try {
            //Convert the acquired data into an FMD object,format is ISO_19794_2_2005;
            Fmd fmTUZHENG_ISO = mImporter.ImportFmd(tuzhengBs, Fmd.Format.ISO_19794_2_2005, Fmd.Format.ISO_19794_2_2005);
            writerLogInTextview("fmTUZHENG_ISO finger import ok!", 1);

            //Convert the acquired data into an FMD object,format is ANSI_378_2004;
            Fmd fmTUZHENG_ISO_TO_ANSI378 = mImporter.ImportFmd(tuzhengBs, Fmd.Format.ISO_19794_2_2005, Fmd.Format.ANSI_378_2004);
            writerLogInTextview("fmTUZHENG_ISO_TO_ANSI378 finger ok!", 1);

            // use crossmatch sdk : "engine.Compare"
            /*
             * Compare
             * int Compare(Fmd fmd1,
             *           int view_index1,
             *           Fmd fmd2,
             *           int view_index2)
             *           throws UareUException
             * Compares two fingerprints.
             * Given two single views from two FMDs, this function returns a dissimilarity score indicating the quality of the match. The dissimilarity scores returned values are between: 0=match PROBABILITY_ONE=no match Values close to 0 indicate very close matches, values closer to PROBABILITY_ONE indicate very poor matches. For a discussion of how to evaluate dissimilarity scores, as well as the statistical validity of the dissimilarity score and error rates, consult the Developer Guide.
             *
             * Parameters:
             * fmd1 - First FMD.
             * view_index1 - Index of the view in the first FMD.
             * fmd2 - Second FMD.
             * view_index2 - Index of the view in the second FMD.
             * Returns:
             * Dissimilarity score.
             * Throws:
             * UareUException - if failed to perform comparison.
             * */

            //The parameter is the fmd object converted above.
            int score = mEngine.Compare(fmTUZHENG_ISO, 0, fmTUZHENG_ISO_TO_ANSI378, 0);

            //compare myself, score: 0=match
            if (score == 0) {
                writerLogInTextview("Compare fmTUZHENG_ISO and fmTUZHENG_ISO_TO_ANSI378 fingerprint success!", 1);
            } else {
                writerLogInTextview("Compare fmTUZHENG_ISO and fmTUZHENG_ISO_TO_ANSI378 fingerprint failed!", 2);
            }

            Log.i("ConvertDiffFinger", String.format("mEngine.Compare,score = %d", score));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private byte[] getTuzhengData() {
        try {
            Fingerprint fingerprint1 = device.getFingerprint(1);//1 = ISOFINGERPRINT_TYPE_ISO2005
            return fingerprint1.getFeature();
        } catch (DeviceException e) {
            writerLogInTextview(e.getMessage(), 2);
            e.printStackTrace();
        }
        return null;
    }

    private byte[] getcrossmatchData() {
        byte[] crossmatchBs = null;
        IFPMgr fpMgr = new FPMgrImpl() {
            @Override
            protected void onDisplayMessage(String message) {
            writerLogInTextview(message,0);    
            }
      };             try {
            fpMgr.open(this);
            //fpMgr.deleteAll(this);
            writerLogInTextview("press finger keep,enroll ", 0);
            try {

                byte[] image = fpMgr.GrabImage(PtConstants.PT_GRAB_TYPE_508_508_8_SCAN508_508_8);
                int iWidth = fpMgr.getImagewidth();
                //get fingerprint , format is ANSI_378
                Fmd fm = ConvertImgToIsoTemplate(image, iWidth);
                //Fmd fm1 = im.ImportFmd(readFingerprintData(), Fmd.Format.ISO_19794_2_2005, Fmd.Format.ISO_19794_2_2005);
                if (fm != null) {
                    byte[] bs = fm.getData();
                    crossmatchBs = bs;
                    //Log.e("fp", "" + HexString.bufferToHex(bs));
                    writerLogInTextview("crossmatch enroll success!", 1);
                } else {
                    Log.e("fm", "fm is null");
                    writerLogInTextview("crossmatch enroll failed!", 2);
                }
            } catch (PtException e) {
                writerLogInTextview("exception " + e.getMessage(), 2);
            }
        } catch (Exception e) {
            e.printStackTrace();
            writerLogInTextview("exception occured !" + e.getMessage(), 2);
        } finally {
            fpMgr.close();
        }
        return crossmatchBs;
    }

    private Fmd ConvertImgToIsoTemplate(byte[] aImage, int iWidth) {
        if (aImage == null) {
            return null;
        }
        int iHeight = aImage.length / iWidth;
        try {
            Engine engine = UareUGlobal.GetEngine();
            Fmd fmd = engine.CreateFmd(aImage, iWidth, iHeight, 500, 0, 0, Fmd.Format.ANSI_378_2004);
            Log.i("BasicSample", "Import a Fmd from a raw image OK");
            return fmd;
        } catch (UareUException e) {
            Log.d("BasicSample", "Import Raw Image Fail", e);
            return null;
        }
    }

    private String checkDeviceType() {
        return getProperty("wp.fingerprint.model", "not");
    }

    public static String getProperty(String key, String defaultValue) {
        String value = defaultValue;
        try {
            Class<?> c = Class.forName("android.os.SystemProperties");
            Method get = c.getMethod("get", String.class, String.class);
            value = (String) (get.invoke(c, key, defaultValue));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return value;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (device != null) {
            try {
                device.close();
            } catch (DeviceException e) {
                e.printStackTrace();
                Log.d("ConvertDiffFinger", "onDestroy,device.close()");
            }
        }
    }
}
        



