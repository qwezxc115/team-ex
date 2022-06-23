package com.team.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Application Lifecycle Listener implementation class BoardListener
 *
 */
public class AppListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AppListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	ServletContext application = sce.getServletContext();
    	application.setAttribute("appRoot", application.getContextPath());
    	

    	// aws s3 bucket 주소
    	String bucketUrl = "https://bucket0207-0308.s3.ap-northeast-2.amazonaws.com/";
    	application.setAttribute("imgRoot", bucketUrl);
    }
	
}
