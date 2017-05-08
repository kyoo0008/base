package egovframework.com.sec.rnc.service;

import java.io.InputStream;
import java.io.PrintWriter;
import java.net.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class EgovNameCheck {

	public int ErrCode;
	private String Host;
	private String Enckey;
    private String ChkName;
    private String Jumin;
    private String SiteCode;
    private String EncJumin;
    private int TimeOut;
    final short PROC_OK = 0;
    final short DATA_ERR = 21;
    
    public EgovNameCheck()
    {
        ErrCode = 0;
        ChkName = "";
        Jumin = "";
        SiteCode = "";
        EncJumin = "";
        TimeOut = 0;
    }

    public String getEnc()
    {
        return EncJumin;
    }

    public void setHost(String s)
    {
    	Host = s;
    }

    public void setEnckey(String s)
    {
    	Enckey = s;
    }
    
    public void setChkName(String s)
    {
        ChkName = s;
    }

    public String setJumin(String s)
    {
        Jumin = s.trim();
        
        return String.valueOf(getEncJumin(Jumin, 21));
    }

    public void setSiteCode(String s)
    {
        SiteCode = s;
    }

    public void setTimeOut(int i)
    {
        TimeOut = i;
    }

    public String getRtn()
    {
        return getNameCheck();
    }

    private int getRandom()
    {
        return Math.abs((new Long(System.currentTimeMillis())).intValue());
    }

    private String getNameCheck()
    {
        String s = "";
        Socket socket = null;
        InputStream inputstream = null;
        PrintWriter printwriter = null;
        try
        {
            int i = getRandom();
            String s1 = Host;
            URL url = new URL(s1);
            String s2 = url.getHost();
            int j = 81 + i % 5;
            String s3 = url.getFile();
            socket = new Socket(s2, j);
            socket.setSoTimeout(TimeOut);
            printwriter = new PrintWriter(socket.getOutputStream(), false);
            inputstream = socket.getInputStream();
            StringBuffer stringbuffer = new StringBuffer();
            stringbuffer.append(URLEncoder.encode("a3", "EUC-KR") + "=" + URLEncoder.encode(ChkName, "EUC-KR") + "&");
            stringbuffer.append(URLEncoder.encode("a2", "EUC-KR") + "=" + URLEncoder.encode(EncJumin, "EUC-KR") + "&");
            stringbuffer.append(URLEncoder.encode("a1", "EUC-KR") + "=" + URLEncoder.encode(SiteCode, "EUC-KR"));
            int k = stringbuffer.toString().length();
            StringBuffer stringbuffer1 = new StringBuffer();
            stringbuffer1.append("POST " + s3 + " HTTP/1.1\n");
            stringbuffer1.append("Accept: */*\n");
            stringbuffer1.append("Connection: close\n");
            stringbuffer1.append("Host: wtname.creditbank.co.kr\n");
            stringbuffer1.append("Content-Type: application/x-www-form-urlencoded\n");
            stringbuffer1.append("Content-Length: " + k + "\r\n");
            stringbuffer1.append("\r\n");
            stringbuffer1.append(stringbuffer.toString());
            printwriter.print(stringbuffer1.toString());
            printwriter.flush();
            stringbuffer1.setLength(0);
            String s4 = "";
            int l = 0;
            for(boolean flag = true; flag && l != -1; flag = (l = inputstream.read()) != 114 ? true : (l = inputstream.read()) != 101 ? true : (l = inputstream.read()) != 115 ? true : (l = inputstream.read()) != 117 ? true : (l = inputstream.read()) != 108 ? true : (l = inputstream.read()) != 116 ? true : (l = inputstream.read()) != 61);
            byte abyte0[] = new byte[2];
            inputstream.read(abyte0);
            printwriter.close();
            inputstream.close();
            socket.close();
            socket = null;
            inputstream = null;
            printwriter = null;
            s = (new String(abyte0, "KSC5601")).toString();
            
        }
        catch(MalformedURLException malformedurlexception)
        {
            if(printwriter != null)
                try
                {
                    printwriter.close();
                    printwriter = null;
                }
                catch(Exception exception) { }
            if(inputstream != null)
                try
                {
                    inputstream.close();
                    inputstream = null;
                }
                catch(Exception exception1) { }
            if(socket != null)
                try
                {
                    socket.close();
                    socket = null;
                }
                catch(Exception exception2) { }
            s = "62";
        }
        catch(NoRouteToHostException noroutetohostexception)
        {
            if(printwriter != null)
                try
                {
                    printwriter.close();
                    printwriter = null;
                }
                catch(Exception exception3) { }
            if(inputstream != null)
                try
                {
                    inputstream.close();
                    inputstream = null;
                }
                catch(Exception exception4) { }
            if(socket != null)
                try
                {
                    socket.close();
                    socket = null;
                }
                catch(Exception exception5) { }
            s = "61";
        }
        catch(Exception exception6)
        {
            if(printwriter != null)
                try
                {
                    printwriter.close();
                    printwriter = null;
                }
                catch(Exception exception7) { }
            if(inputstream != null)
                try
                {
                    inputstream.close();
                    inputstream = null;
                }
                catch(Exception exception8) { }
            if(socket != null)
                try
                {
                    socket.close();
                    socket = null;
                }
                catch(Exception exception9) { }
            s = "63";
        }
        finally
        {
            if(printwriter != null)
                try
                {
                    printwriter.close();
                    printwriter = null;
                }
                catch(Exception exception11) { }
            if(inputstream != null)
                try
                {
                    inputstream.close();
                    inputstream = null;
                }
                catch(Exception exception12) { }
            if(socket != null)
                try
                {
                    socket.close();
                    socket = null;
                }
                catch(Exception exception13) { }
        }
        return s;
    }

    private int getEncJumin(String s, int i)
    {
        String s1 = Enckey;
        int j = 0;
        int k = 0;
        int l = 0;
        int i1 = 0;
        int j1 = 0;
        String s2 = "";
        String s5 = "";
        String s7 = s;
        String s8 = "00";
        String s9 = "";
        String s10 = "";
        String s13 = "";
        s7.trim();
        if(i != s7.length())
            return 21;
        j = i - (i / 3) * 3;
        if(j == 2)
            s7 = s7 + "00";
        else
        if(j == 1)
            s7 = s7 + "0";
        k = (int)(Math.random() * 100D);
        s13 = s1.substring(k * 5, k * 5 + 5);
        l = Integer.valueOf(s13).intValue();
        i1 = s7.length() / 3 / 2;
        DecimalFormat decimalformat = null;
        decimalformat = new DecimalFormat("00");
        s9 = decimalformat.format(k);
        decimalformat = new DecimalFormat("00000");
        for(j1 = 0; j1 < i1; j1++)
        {
            String s11 = s7.substring(j1 * 2 * 3, j1 * 2 * 3 + 3);
            String s3 = decimalformat.format((new Integer(s11)).intValue() + l);
            s11 = s7.substring((j1 * 2 + 1) * 3, (j1 * 2 + 1) * 3 + 3);
            String s6 = decimalformat.format((new Integer(s11)).intValue() + l);
            s9 = s9 + s6;
            s9 = s9 + s3;
        }

        if(i1 * 2 < s7.length() / 3)
        {
            String s12 = s7.substring(j1 * 2 * 3, j1 * 2 * 3 + 3);
            String s4 = decimalformat.format((new Integer(s12)).intValue() + l);
            s9 = s9 + s4;
        }
        EncJumin = s9;
        return 0;
    }
    
}
