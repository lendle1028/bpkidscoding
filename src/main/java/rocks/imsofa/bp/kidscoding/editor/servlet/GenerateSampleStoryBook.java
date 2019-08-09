/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.servlet;

import com.google.gson.Gson;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBook;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta;
import rocks.imsofa.bp.kidscoding.editor.service.StoryBookService;

/**
 *
 * @author lendle
 */
@WebServlet(name = "GenerateSampleStoryBook", urlPatterns = {"/storybook/generateSample"})
public class GenerateSampleStoryBook extends HttpServlet {
    @Autowired
    private StoryBookService storyBookService;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private List<String> animals=null;
    
    public void setStoryBookService(StoryBookService storyBookService) {
        this.storyBookService = storyBookService;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this,
                config.getServletContext());
        File file=new File(getServletContext().getRealPath("/WEB-INF/animals.txt"));
        try {
            animals=FileUtils.readLines(file);
        } catch (IOException ex) {
            Logger.getLogger(GenerateSampleStoryBook.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        SimpleDateFormat format=new SimpleDateFormat("yyyyMMdd");
        
        List<Map<String, Object>> list=jdbcTemplate.queryForList("select * from users");
        StoryBook book=new StoryBook();
        StoryBookMeta meta=new StoryBookMeta();
        int authorId=(Integer)(list.get((int) (Math.random()*Integer.MAX_VALUE%list.size())).get("id"));
        meta.setAuthor(authorId);
        meta.setCreatedDate(format.format(new Date()));
        meta.setLastEditedDate(format.format(new Date()));
        meta.setSummary(this.generateParagraph(10));
        meta.setTitle(this.generateParagraph(5));
        
        String character1=this.generateParagraph(1);
        String character2=this.generateParagraph(1);

        String [] characters=new String[]{character1, character2};
        
        meta.setCharacters("{\"time\": "+System.currentTimeMillis()+", \"version\": \"2.15.0\", \"blocks\": ["+
                this.generateCharacterQuoteBlock(character1, this.generateParagraph(20))+", "+
                this.generateCharacterQuoteBlock(character2, this.generateParagraph(20))+"]}");
        book.setMeta(meta);
        
        List<String> contents=new ArrayList<>();
        for(int i=0; i<10; i++){
            contents.add("{ \"time\": "+System.currentTimeMillis()+
                    ", \"blocks\": ["+this.generateCharacterQuoteBlock(character1, this.generateParagraph(20))+", { \"type\": \"os\", \"data\": { \"message\": \""+
                    this.generateParagraph(10)+"\" } }, { \"type\": \"separator\", \"data\": {} }, "+
                    this.generateCharacterQuoteBlock(character2, this.generateParagraph(20))+"], "
                    + "\"version\": \"2.15.0\" }");
        }
        book.setPageContents(contents);
        storyBookService.addStoryBook(book);
        
        try (PrintWriter out = response.getWriter()) {
            out.print(new Gson().toJson(book));
        }
    }
    
    private String generateParagraph(int wordCount){
        StringBuffer buffer=new StringBuffer();
        for(int i=0; i<wordCount; i++){
            if(buffer.length()>0){
                buffer.append(" ");
            }
            int index=(int) (Math.random()*Integer.MAX_VALUE%animals.size());
            buffer.append(animals.get(index));
        }
        return buffer.toString();
    }
    
    public String generateCharacterQuoteBlock(String character, String quote){
        return "{\"type\": \"characterQuote\", \"data\": {\"character\": \""+character+"\", \"message\": \""+quote+"\"} }";
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
