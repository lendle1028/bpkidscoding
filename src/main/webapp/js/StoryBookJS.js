class StoryBookJS{
    constructor(root){
        this.rootURL=root+"/webapi";
    }

    getStoryBook(id){
        let url=this.rootURL+"/book/"+id;
        let self=this;
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                contentType: "application/json",
                success: function(data){
                    //console.log(data);
                    //console.log(self.structured4API(self.flatten4Display(data)));
                    resolve(self.flatten4Display(data));
                },
                error: function(xhr){
                    reject(xhr);
                }
            });
        });
        return p;
    }

    addStoryBook(book){
        let url=this.rootURL+"/book";
        let self=this;
        if(book.characters){
            //then we have to re-structure this
            //since it is flattened for editorJS
            book=this.structured4API(book);
        }
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(book),
                success: function(data){
                    resolve(self.flatten4Display(data));
                },
                error: function(xhr){
                    reject(xhr);
                }
            });
        });
        return p;
    }

    updateStoryBook(book){
        let url=this.rootURL+"/book";
        let self=this;
        if(book.characters){
            //then we have to re-structure this
            //since it is flattened for editorJS
            book=this.structured4API(book);
        }
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                type: "PUT",
                contentType: "application/json",
                data: JSON.stringify(book),
                success: function(data){
                    resolve(self.flatten4Display(data));
                },
                error: function(xhr){
                    reject(xhr);
                }
            });
        });
        return p;
    }

    deleteStoryBook(id){
        let url=this.rootURL+"/book/"+id;
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                type: "DELETE",
                success: function(data){
                    resolve(data);
                },
                error: function(xhr){
                    reject(xhr);
                }
            });
        });
        return p;
    }

    /**
     * flatten the book data for easier diaply
     * for editorJS
     * @param {*} book 
     */
    flatten4Display(book){
        return {
            id: book.meta.id,
            meta: book.meta,
            title: book.meta.title,
            summary: { "time": new Date().getTime(), "blocks": [{ "type": "os", "data": { "message": book.meta.summary } }], "version": "2.15.0" },
            characters: book.meta.characters,
            data: book.pageContents
        };
    }
    /**
     * (re)structure the data controlled by editorJS
     * to the format of the WS API
     * @param {*} book 
     */
    structured4API(book){
        return {
            id: book.id,
            meta: book.meta,
            pageContents: book.data
        };
    }
}