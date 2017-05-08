package egovframework.com.sec.rnc.service;

import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.InetAddress;
import java.net.Socket;

/**
 * G4C 연계용    배포파일- TimedSocket.java
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
public class EgovTimedSocket
{
	/**
	  * 특정주소로 연결시도한다.(InetAdress로 연결)
	  *
	  *	@param	iaddr	hostaddress 
	  *	@param	connectPort	service port
	  * @param	delayTime	Delay(milliseconds)
	  */
	public static Socket getSocketClient ( InetAddress iaddr, int connectPort, int delayTime) throws InterruptedIOException, IOException
	{
		SocketAction sa = new SocketAction( iaddr, connectPort );
		sa.start();

		int timeCheck = 0;
		Socket socket = null;

		for (;;)
		{
			if (sa.isConnected()){
				socket = sa.getSocketThread();
				break;
			}
			else
			{
				if (sa.isFail()){
					sa.getException();
				}

				try{
					Thread.sleep ( TIME_DELAY );
				}
				catch (InterruptedException ine) {}

				timeCheck += TIME_DELAY;

				if (timeCheck > delayTime){
					throw new InterruptedIOException("connect fail , time over : " + delayTime);
				}
			}
		}

		return socket;
	}

	/**
	  * 특정주소로  연결시도한다.(주소로 직접 연결)
	  *
	  *	@param	ihost	hostname
	  *	@param	connectPort	Port of service
	  * @param	delayTime	Delay in milliseconds
	  */
	public static Socket getSocketClient ( String ihost, int connectPort, int delayTime) throws InterruptedIOException, IOException
	{
		InetAddress inetAddr = InetAddress.getByName (ihost);
		return getSocketClient ( inetAddr, connectPort, delayTime );
	}

	/**
     * 배포된 파일을 로컬에서 직접테스트시  참조할 수 있는 코드(직접실행시 사용)
     */
	public static void main(String args[]) throws Exception
	{
		Socket s = null;
		try
		{
			s = EgovTimedSocket.getSocketClient ("192.168.100.21", 80, 5000);
		}
		catch (IOException ioe)
		{
			ioe.printStackTrace();
		} finally {
			if(s != null) {
				try {s.close();} catch(Exception e) {}
			}
		}

	}

	// Inner class 
	/**
	 * @author  J2Soft
	 */
	static class SocketAction extends Thread
	{
		/**
		 * @uml.property  name="threadSocket"
		 */
		volatile private Socket threadSocket = null;
		private String threadHost       = null;
		/**
		 * @uml.property  name="threadInetAddr"
		 */
		private InetAddress threadInetAddr  = null;
		private int    threadPort       = 0;
		private IOException threadException = null;

		public SocketAction ( String host, int port)
		{
			threadHost = host;
			threadPort = port;
		}

		public SocketAction ( InetAddress inetAddr, int port )
		{
			threadInetAddr = inetAddr;
			threadPort = port;
		}
		
		public SocketAction ( InetAddress inetAddr, String host, int port )
		{
			if(host!=null){
				threadHost = host;
				threadPort = port;
			}else if(inetAddr!=null){
				threadInetAddr = inetAddr;
				threadPort = port;
			}
		}
		
		public void run()
		{
			Socket sock = null;

			try
			{
				if (threadHost != null)	{
					sock = new Socket (threadHost, threadPort);
				}
				else{
					sock = new Socket (threadInetAddr, threadPort);
				}
			}
			catch (IOException ioe)
			{
				threadException = ioe;
				return;
			} finally {
				if(sock != null) {
					try {sock.close();} catch(Exception e) {}
				}
			}
			
			threadSocket = sock;
		}
		
		public Socket getSocketThread()
		{
			return threadSocket;
		}
		
		public boolean isFail()
		{
			if (threadException == null)
				return false;
			else
				return true;
		}
		
		public boolean isConnected()
		{
			if (threadSocket == null)
				return false;
			else
				return true;
		}
		
		/**
		 * @return
		 * @uml.property  name="threadSocket"
		 */
		public String getThreadSocket()
		{
			if (threadSocket == null)
				return "";
			else
				return threadHost;
		}
		
		/**
		 * @return
		 * @uml.property  name="threadInetAddr"
		 */
		public String getThreadInetAddr()
		{
			if (threadInetAddr == null)
				return "";
			else
				return threadInetAddr.getHostAddress();
		}

		public IOException getException()
		{
			return threadException;
		}
	}

	private static final int TIME_DELAY = 100;
}
