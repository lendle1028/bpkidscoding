/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Web application lifecycle listener.
 *
 * @author lendle
 */
public class StartupListener implements ServletContextListener {
    @Autowired
    private org.springframework.jdbc.datasource.DriverManagerDataSource dataSource;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext=sce.getServletContext();
        dataSource.setUrl("jdbc:hsqldb:file:"+servletContext.getRealPath("/WEB-INF/db"));
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
