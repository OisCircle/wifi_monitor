import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import com.qcq.wifi_monitor.entity.Info;
import com.qcq.wifi_monitor.entity.Seeker;

public class Test {
	static List<Info> infos=new ArrayList<Info>();
	static BlockingQueue<Date> time=new ArrayBlockingQueue<Date>(2);
	static BlockingQueue<Seeker> seekers=new ArrayBlockingQueue<Seeker>(2);
	
	
	public static void main(String[] args) {
		
		
	}
}
