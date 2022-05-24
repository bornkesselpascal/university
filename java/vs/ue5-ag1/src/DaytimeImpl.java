import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.text.SimpleDateFormat;

public class DaytimeImpl extends UnicastRemoteObject implements Daytime {
	public DaytimeImpl() throws RemoteException {
	}

	public String getTime() {
		return new SimpleDateFormat("yyyy.MM.dd HH.mm.ss").format(new java.util.Date());
	}
}
