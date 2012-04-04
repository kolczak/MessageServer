package com.kolczak.messageserver;

import java.io.IOException;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import java.util.Date;
import java.util.logging.Logger;

@SuppressWarnings("serial")
public class MessageServerServlet extends HttpServlet {
	
	private static final Logger log = Logger.getLogger(MessageServerServlet.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
//		resp.setContentType("text/plain");
//		resp.getWriter().println("Hello, world");
		resp.sendRedirect("/index.html ");
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String author = req.getParameter("author");
		String content = req.getParameter("content");
		
		log.info("Received post: " + author + ", " + content);
		
		if (content != null && author != null) {
			Key messagesKey = KeyFactory.createKey("MessagesStore", "MessagesStore");
	        Date date = new Date();
	        Entity message = new Entity("Messages", messagesKey);
	        message.setProperty("author", author);
	        message.setProperty("content", content);
	        message.setProperty("date", date);

	        DatastoreService datastore =
	                DatastoreServiceFactory.getDatastoreService();
	        datastore.put(message);
		}
		resp.sendRedirect("/messages.jsp");
	}
}
