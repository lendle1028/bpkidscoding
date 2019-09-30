class PictureBookMetaJS{
    constructor(root){
        this.rootURL=root+"/webapi";
    }
    
    findByStoryBook(storyBookId){
        let url=this.rootURL+"/picturebook/storybook/"+storyBookId;
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                contentType: "application/json",
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
    
    findByAuthor(authorId){
        let url=this.rootURL+"/picturebook/author/"+authorId
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                contentType: "application/json",
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
    
    findById(id){
        let url=this.rootURL+"/picturebook/"+id
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                contentType: "application/json",
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

    addPictureBookMeta(book){
        let url=this.rootURL+"/picturebook";
        
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(book),
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

    updatePictureBookMeta(book){
        let url=this.rootURL+"/picturebook";
        
        let p=new Promise((resolve, reject)=>{
            $.ajax(url, {
                type: "PUT",
                contentType: "application/json",
                data: JSON.stringify(book),
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

    deletePictureBookMeta(id){
        let url=this.rootURL+"/picturebook/"+id;
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
}