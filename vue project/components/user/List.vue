<template>
  <div>
    <el-table
      :data="tableData.filter(data => !search || data.name.toLowerCase().includes(search.toLowerCase()))"
      style="width: 100%">
      <el-table-column
        label="编号"
        prop="id">
      </el-table-column>
      <el-table-column
        label="姓名"
        prop="name">
      </el-table-column>
      <el-table-column
        label="性别"
        prop="sex">
      </el-table-column>
      <el-table-column
        label="生日"
        prop="bir">
      </el-table-column>
      <el-table-column
        label="地址"
        prop="addr">
      </el-table-column>
      <el-table-column
        align="right">
        <template slot="header" slot-scope="scope">
          <el-input
            v-model="search"
            size="mini"
            placeholder="输入姓名关键字搜索"/>
        </template>
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row.id)">编辑
          </el-button>
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row.id)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="text-align: left">
      <el-button @click="show = !show" style="margin-top: 20px">添加</el-button>

      <div style="margin-top: 20px; height: 200px;">
        <el-collapse-transition>
          <div v-show="show">
            <div class="transition-box">
              <el-form ref="form" :model="form" label-width="80px">
                <el-form-item label="姓名">
                  <el-input v-model="form.name"></el-input>
                </el-form-item>
                <el-form-item label="生日">
                  <el-date-picker type="date" placeholder="选择日期" v-model="form.bir"
                                  style="width: 100%;"></el-date-picker>
                </el-form-item>
                <el-form-item label="性别">
                  <el-radio-group v-model="form.sex">
                    <el-radio label="男"></el-radio>
                    <el-radio label="女"></el-radio>
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="地址">
                  <el-input type="textarea" v-model="form.addr"></el-input>
                </el-form-item>
                <el-form-item class="submit_button">
                  <el-button type="primary" @click="onSubmit">
                    <span v-if="form.id === ''">提交添加</span>
                    <span v-else>提交编辑</span></el-button>
                  <el-button @click="reSet">重置</el-button>
                </el-form-item>
              </el-form>
            </div>
          </div>
        </el-collapse-transition>
      </div>
    </div>
  </div>

</template>

<script>
  export default {
    name: "List",
    data() {
      return {
        tableData: [],
        search: '',
        show: true,
        form: {
          id: '',
          name: '',
          bir: '',
          sex: '男',
          addr: ''
        }
      }
    },
    methods: {
      handleDelete(index, id) {
        console.log(index, id);
        let _this = this;
        this.$http.post("http://localhost:8989/user/deleteUser", {params_1: id}).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.form = {sex: '男'};
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      handleEdit(index, id) {
        console.log(index, id);
        let _this = this;
        this.$http.post('http://localhost:8989/user/edit', {params_1: id}).then(function (res) {
          console.log(res);
          _this.form = res.data[0];
          _this.show = true

        }).catch(function (err) {
          console.log(err);
        })
      },
      onSubmit() {
        let _this = this;
        console.log(_this.form);
        this.$http.post("http://localhost:8989/user/save", this.form).then(function (res) {
          console.log(res.data);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.form = {sex: '男'};
          } else {
            alert(res.data.message);
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        });
      },
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/user/findAll').then(function (res) {
          console.log(res);
          _this.tableData = res.data;

        }).catch(function (err) {
          console.log(err);
        })
      },
      reSet() {
        this.form = {
          id: '',
          name: '',
          bir: '',
          sex: '男',
          addr: ''
        };
        console.log(this.form);
      }
    },
    created() {
      this.findAll();

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
