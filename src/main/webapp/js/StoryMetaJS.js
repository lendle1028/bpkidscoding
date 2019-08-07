/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class StoryMetaJS{
    constructor(root){
        this.rootURL=root+"/webapi";
    }

    findAll(pageSize=100, pageIndex=0){
        let p=new Promise((resolve, reject)=>{
            $.ajax(this.rootURL+"/meta?pageSize="+pageSize+"&pageIndex="+pageIndex, {
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
        let p=new Promise((resolve, reject)=>{
            $.ajax(this.rootURL+"/meta/"+id+"?pageSize="+pageSize+"&pageIndex="+pageIndex, {
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

