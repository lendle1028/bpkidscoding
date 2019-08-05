/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author lendle
 */
public class StoryBookMetaRowMapper implements RowMapper<StoryBookMeta>{

    @Override
    public StoryBookMeta mapRow(ResultSet rs, int i) throws SQLException {
        StoryBookMeta meta=new StoryBookMeta();
        meta.setAuthor(rs.getInt("author"));
        meta.setCharacters(rs.getString("characters"));
        meta.setCreatedDate(rs.getString("created_date"));
        meta.setLastEditedDate(rs.getString("last_edited_date"));
        meta.setId(rs.getString("id"));
        meta.setSummary(rs.getString("summary"));
        meta.setTitle(rs.getString("title"));
        return meta;
    }
    
}
