class StoryBookJS{
    constructor(root){
        this.rootURL=root+"/webapi";
    }

    getStoryBook(id){
        let url=this.rootURL+"/book/"+id;
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

    addStoryBook(book){
        let url=this.rootURL+"/book";
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

    updateStoryBook(book){
        let url=this.rootURL+"/book";
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
}