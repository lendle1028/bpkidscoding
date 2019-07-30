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
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

/**
 * Web application lifecycle listener.
 *
 * @author lendle
 */
public class StartupListener implements ServletContextListener {
    @Autowired
    private org.springframework.jdbc.datasource.DriverManagerDataSource dataSource;
    @Autowired
    private org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

    public void setDataSource(DriverManagerDataSource dataSource) {
        this.dataSource = dataSource;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
        ServletContext servletContext=sce.getServletContext();
        dataSource.setUrl("jdbc:hsqldb:file:"+servletContext.getRealPath("/WEB-INF/db"));
        SqlRowSet rowSet=jdbcTemplate.queryForRowSet("select * from test");
        while(rowSet.next()){
            System.out.println(rowSet.getString("value"));
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
