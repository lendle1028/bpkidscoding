/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class StoryMetaJS{
    constructor(root){
        this.rootURL=root+"/webapi";
    }
    
    count(){
        return this.query(this.rootURL+"/meta/count");
    }
    
    findAll(pageSize=100, pageIndex=0){
        return this.query(this.rootURL+"/meta?pageSize="+pageSize+"&pageIndex="+pageIndex);
    }

    findById(id){
        return this.query(this.rootURL+"/meta/"+id+"?pageSize="+pageSize+"&pageIndex="+pageIndex);
    }

    findByAuthor(author, pageSize=100, pageIndex=0){
        return this.query(this.rootURL+"/meta/author/"+author+"?pageSize="+pageSize+"&pageIndex="+pageIndex);
    }

    findByKeywords(keyword, pageSize=100, pageIndex=0){
        return this.query(this.rootURL+"/meta/keyword/"+keyword+"?pageSize="+pageSize+"&pageIndex="+pageIndex);
    }

    query(url){
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
}

