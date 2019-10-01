/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

import com.google.gson.Gson;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import org.springframework.jdbc.core.RowMapper;
import rocks.imsofa.bp.kidscoding.editor.model.StoryBookMeta.Characters;

/**
 *
 * @author lendle
 */
public class StoryBookMetaRowMapper implements RowMapper<StoryBookMeta>{

    @Override
    public StoryBookMeta mapRow(ResultSet rs, int i) throws SQLException {
        StoryBookMeta meta=new StoryBookMeta();
        meta.setAuthor(rs.getInt("author"));
        meta.setCharacters(new Gson().fromJson(rs.getString("characters"), Characters.class));
        meta.setCreatedDate(rs.getString("created_date"));
        meta.setLastEditedDate(rs.getString("last_edited_date"));
        meta.setId(rs.getString("id"));
        meta.setSummary(rs.getString("summary"));
        meta.setTitle(rs.getString("title"));
        return meta;
    }
    
}
