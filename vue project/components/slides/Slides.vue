<template>
  <el-container>
    <el-header>
      <h2>轮播图管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.description.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="图片id"
            prop="id">
          </el-table-column>
          <el-table-column
            label="图片描述"
            prop="description">
          </el-table-column>
          <el-table-column
            label="图片描述">
            <template slot-scope="scope">
              <el-image style="width: 50px; height: 50px" :src="scope.row.link" fit="fill"></el-image>
            </template>
          </el-table-column>
          <el-table-column
            label="图片链接"
            prop="link">
          </el-table-column>
          <el-table-column
            align="right">
            <template slot="header" slot-scope="scope">
              <el-input
                v-model="search"
                size="mini"
                placeholder="输入描述搜索"/>
            </template>
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleReset(scope.$index, scope.row.id)">修改信息
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row.id)">删除
              </el-button>
            </template>
          </el-table-column>
        </el-table>
        <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
                       :page-sizes="[5, 10, 20, 40]"
                       :page-size="pagesize" layout="total, sizes, prev, pager, next, jumper" :total="showdata.length">
        </el-pagination>
      </div>
    </el-main>
    <el-dialog title="轮播图信息修改" :visible.sync="dialogFormVisible_1">
      <el-form :model="reSetForm" :rules="rules" ref="reSetForm">
        <el-form-item label="id" :label-width="formLabelWidth">
          <el-input v-model="reSetForm.id" autocomplete="off" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="描述" :label-width="formLabelWidth" prop="description">
          <el-input v-model="reSetForm.description" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="链接" :label-width="formLabelWidth" prop="link">
          <el-input v-model="reSetForm.link" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_1">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="轮播图添加" :visible.sync="dialogFormVisible_2">
      <el-form :model="newImgForm" :rules="rules" ref="newImgForm">
        <el-form-item label="描述" :label-width="formLabelWidth" prop="description">
          <el-input v-model="newImgForm.description" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="链接" :label-width="formLabelWidth" prop="link">
          <el-input v-model="newImgForm.link" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_2 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_2">确 定</el-button>
      </div>
    </el-dialog>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="dialogFormVisible_2=true">
      添加轮播图
    </el-button>
  </el-container>
</template>
<script>
  export default {
    name: "Slides",
    data() {
      let validateDescription = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('描述不能为空'));
        } else {
          callback();
        }
      };
      let checkLink = (rule, value, callback) => {
        if (!value) {
          return callback(new Error('链接不能为空'));
        } else {
          callback();
        }
      };
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        search: '',
        dialogFormVisible_1: false,
        dialogFormVisible_2: false,
        formLabelWidth: '120px',
        reSetForm: {
          id: '',
          description: '',
          link: ''

        },
        newImgForm: {
          id: '',
          description: '',
          link: ''

        },
        rules: {
          description: [
            {validator: validateDescription, trigger: 'blur'}
          ],
          link: [
            {validator: checkLink, trigger: 'blur'}
          ]
        }
      };

    },
    methods: {
      dialogConfirmed_2() {
        let _this = this;
        _this.$http.post("http://localhost:8989/saveSlideImg", _this.newImgForm).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.dialogFormVisible_2 = false;
            _this.newImgForm = {};
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });

      },
      dialogConfirmed_1() {
        let _this = this;
        console.log(_this.reSetForm);
        this.$http.post("http://localhost:8989/updateSlideImg", _this.reSetForm).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.dialogFormVisible_1 = false;
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      }
      ,
      handleDelete(index, id) {
        console.log(index, id);
        let _this = this;
        this.$http.post("http://localhost:8989/deleteSlideImg", {params_1: id}).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });

      }
      ,
      handleReset(index, id) {
        let _this = this;
        this.$http.post("http://localhost:8989/findImgById", {params_1: id}).then(function (res) {
          _this.reSetForm = res.data[0];
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      }
      ,
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllSlideImg').then(function (res) {
          console.log(res);
          _this.showdata = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      }
      ,
      handleSizeChange(size) {
        this.pagesize = size;
        console.log(this.pagesize)  //每页下拉显示数据
      }
      ,
      handleCurrentChange(currentPage) {
        this.currentPage = currentPage;
        console.log(this.currentPage)  //点击第几页
      }
    },
    created() {
      this.findAll()
    }
  }
</script>
<style scoped>
  .transition-box {
    margin-bottom: 10px;
    width: 100%;
    height: 400px;
    border-radius: 4px;
    background-color: #ccc;
    text-align: left;
    color: #fff;
    padding: 40px 20px;
    box-sizing: border-box;
    margin-right: 20px;
  }

  .submit_button {
    text-align: center;
    padding-bottom: 20px;
  }

</style>
