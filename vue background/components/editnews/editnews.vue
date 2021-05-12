<template>



  <div>
    <div class="article_box">
      <span class="title-article">请输入标题:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <el-input v-model="newstitle" class="title-article"></el-input>
    </div>
    <!-- 工具栏容器 -->
    <div id="toolbar-container"></div>

    <!-- 编辑器容器 -->
    <div id="editor">
      <p>This is the initial editor content.</p>
    </div>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="concel">
      取消
    </el-button>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="updatenews">
      确定
    </el-button>
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
          const toolbarContainer = document.querySelector('#toolbar-container');
          toolbarContainer.appendChild(editor.ui.view.toolbar.element);
          editor.setData(_this.newscontent);
          _this.editor = editor; //将编辑器保存起来，用来随时获取编辑器中的内容等，执行一些操作
        }).catch(error => {
          console.error(error);
        });
      },
      concel(){
        this.$router.push('/newslist');
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

      },
      updatenews(){
        let _this = this;
        _this.$http({
          method: 'post',
          url: "http://localhost:8000/news/updatenews/",
          data: _this.$qs.stringify({params_1: _this.id,params_2: _this.newstitle, params_3: _this.editor.getData()}),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          console.log(res);
          if (res.data.ret==='success') {
            //refresh
            alert('修改成功');
            _this.$emit('changeparentactiveindex')
          } else {
            alert(res.data.ret);
          }
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
    width: 40%;
  }
  .article_box{
    margin: 30px;
  }
</style>
