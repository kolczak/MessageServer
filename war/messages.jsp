<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Key messageskKey = KeyFactory.createKey("MessagesStore", "MessagesStore");
    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    Query query = new Query("Messages", messageskKey).addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> messages = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
    if (messages.isEmpty()) {
        %>[]<%
    } else {
    	%>[<%
    	int length = messages.size();
    	int i = 1;
    	for (Entity message : messages) {
            if (message.getProperty("author") != null && message.getProperty("content") != null) {
                %>{"author":"<%= message.getProperty("author") %>","content":"<%=message.getProperty("content")%>"}<%
                if (i<length)
                	%>,<%
            } else {
                %>
                <%
            }
            i++;
        }
        %>]<%
    }
%>