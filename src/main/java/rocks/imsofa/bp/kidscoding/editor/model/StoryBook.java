/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rocks.imsofa.bp.kidscoding.editor.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author lendle
 */
public class StoryBook {
    private List<PageContent> pageContents=new ArrayList<>();
    private String id;
    private StoryBookMeta meta=null;

    public List<PageContent> getPageContents() {
        return pageContents;
    }

    public void setPageContents(List<PageContent> pageContents) {
        this.pageContents = pageContents;
    }

    public StoryBookMeta getMeta() {
        return meta;
    }

    public void setMeta(StoryBookMeta meta) {
        this.meta = meta;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public static class PageContent{
        private long time=-1;
        private String version=null;
        private List<PageContentBlock> blocks=new ArrayList<>();

        public long getTime() {
            return time;
        }

        public void setTime(long time) {
            this.time = time;
        }

        public String getVersion() {
            return version;
        }

        public void setVersion(String version) {
            this.version = version;
        }

        public List<PageContentBlock> getBlocks() {
            return blocks;
        }

        public void setBlocks(List<PageContentBlock> blocks) {
            this.blocks = blocks;
        }
        
        
        
        public static class PageContentBlock{
            private String type=null;
            private Map<String, String> data=new HashMap<>();

            public String getType() {
                return type;
            }

            public void setType(String type) {
                this.type = type;
            }

            public Map<String, String> getData() {
                return data;
            }

            public void setData(Map<String, String> data) {
                this.data = data;
            }
            
        }
    }
}
