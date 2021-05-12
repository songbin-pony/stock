<template>



  <div>
    <div class="article_box">
      <h2 v-text="newstitle" class="title-article"></h2>
    </div>
    <!-- 工具栏容器 -->
    <div id="toolbar-container"></div>

    <!-- 编辑器容器 -->
    <div id="editor">
      <p>This is the initial editor content.</p>
    </div>
  </div>
</template>

<script>
  export default {
    name: "news",
    data() {
      return {
        editor: null,//编辑器实例
        newscontent:'',
        newstitle:'',
        id:''
      }
    },
    mounted() {
      this.id=this.$route.query.id;
      this.findnewsbyid();
    },
    methods: {
      initCKEditor() {
        let _this=this;
        _this.$CKEditor.create(document.querySelector('#editor'), {
          ckfinder: {
            uploadUrl: 'http://localhost:8000/upload/uploadimg/'
            //后端处理上传逻辑返回json数据,包括uploaded(选项true/false)和url两个字段
          },
          language: 'zh-cn',
        }).then(editor => {
          editor.setData(_this.newscontent);
          editor.isReadOnly = true;
          _this.editor = editor; //将编辑器保存起来，用来随时获取编辑器中的内容等，执行一些操作
        }).catch(error => {
          console.error(error);
        });
      },
      findnewsbyid(){
        let _this = this;
        _this.$http({
          method: 'post',
          url: "http://localhost:8000/news/findnewsbyid/",
          data: _this.$qs.stringify({params_1: _this.id}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.newstitle=res.data[0].newstitle;
          _this.newscontent=res.data[0].newscontent;
          _this.initCKEditor();
        }).catch(function (err) {
          console.log(err);
        });

      }
    }
  }
</script>

<style scoped>
  .title-article {
    font-size: 28px;
    word-wrap: break-word;
    color: #222226;
    font-weight: 600;
    margin: 0;
    word-break: break-all;
  }
  .article_box{
    margin: 30px;
  }
</style>
