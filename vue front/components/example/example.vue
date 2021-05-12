<template>
  <div>
    <div class="print-page">
      <el-table
        :data="showdata"
        style="width: 100%">
        <el-table-column
          prop="id"
          label="编号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="name"
          label="姓名"
          width="180">
        </el-table-column>
        <el-table-column
          prop="phonenumber"
          label="电话"
          width="180">
        </el-table-column>
        <el-table-column
          prop="address"
          label="地址"
          width="180">
        </el-table-column>
        <el-table-column
          align="right">
          <template slot="header" slot-scope="scope">
            <el-input v-model="search" size="mini" placeholder="输入姓名或电话搜索" @input="searchfunc"/>
          </template>
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handledelcustomer(scope.$index, scope.row.id)">移除
            </el-button>
            <el-button
              size="mini"
              type="primary"
              @click="handleupdate(scope.$index, scope.row.id)">修改
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="dialogFormVisible_2=true">
      添加用户
    </el-button>
    <el-dialog title="信息修改" :visible.sync="dialogFormVisible_1">
      <el-form :model="updateform">
        <el-form-item label="编号" :label-width="formLabelWidth">
          <el-input v-model="updateform.id" autocomplete="off" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="名字" :label-width="formLabelWidth">
          <el-input v-model="updateform.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth">
          <el-input v-model="updateform.phonenumber" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址" :label-width="formLabelWidth">
          <el-input v-model="updateform.address" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_1">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="用户添加" :visible.sync="dialogFormVisible_2">
      <el-form :model="addform">
        <el-form-item label="名字" :label-width="formLabelWidth">
          <el-input v-model="addform.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth">
          <el-input v-model="addform.phonenumber" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址" :label-width="formLabelWidth">
          <el-input v-model="addform.address" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_2 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_2">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: "example",
    props: ["username"],
    data() {
      return {
        showdata: {},
        search: '',
        updateform:[],
        addform:[],
        formLabelWidth: '120px',
        dialogFormVisible_1: false,
        dialogFormVisible_2: false,
      }
    },
    methods: {
      findallcustomers() {
        let _this = this;
        this.$http({
          method: 'post',
          url: "http://localhost:8000/sales/customers/",
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        }).then(function (res) {
          _this.showdata = res.data;

        }).catch(function (err) {
          console.log(err);
        })
      },
      searchfunc() {
        let _this = this;
        this.$http(
          {
            method: 'post',
            url: "http://localhost:8000/sales/customers/",
            data: _this.$qs.stringify({'params_1': _this.search}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        ).then(function (res) {
          _this.showdata = res.data;

        }).catch(function (err) {
          console.log(err);
        })
      },
      handledelcustomer(index, id) {
        console.log(index, id);
        let _this = this;
        this.$http(
          {
            method: 'post',
            url: "http://localhost:8000/sales/delcustomer/",
            data: _this.$qs.stringify({'params_1': id}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        ).then(function (res) {

          console.log(res.data);
          if (res.data.ret == 'success') {
            alert('删除成功');
            _this.findallcustomers();
          }

        }).catch(function (err) {
          console.log(err);
        })

      },
      handleupdate(index, id) {
        let _this = this;
        console.log(index, id);
        this.$http(
          {
            method: 'post',
            url: "http://localhost:8000/sales/findcustomerbyid/",
            data: _this.$qs.stringify({'params_1': id}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        ).then(function (res) {
          console.log(res.data);
          _this.updateform = res.data[0];
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      },
      dialogConfirmed_1(){
        let _this=this;
        console.log(_this.updateform);
        this.$http(
          {
            method: 'post',
            url: "http://localhost:8000/sales/updatecustomer/",
            data: _this.$qs.stringify({'params_1': _this.updateform}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        ).then(function (res) {
          console.log(res);
          if (res.data.ret=='success') {
            //refresh
            alert('更新成功');
            _this.findallcustomers();
            _this.dialogFormVisible_1 = false;
          } else {
            alert('更新失败');
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        })

      },
      dialogConfirmed_2(){
        let _this=this;
        console.log(_this.addform);
        this.$http(
          {
            method: 'post',
            url: "http://localhost:8000/sales/addcustomer/",
            data: _this.$qs.stringify({'params_1': _this.addform}),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        ).then(function (res) {
          console.log(res);
          if (res.data.ret=='success') {
            //refresh
            alert('添加成功');
            _this.findallcustomers();
            _this.dialogFormVisible_2 = false;
            _this.addform=[];
          } else {
            alert('添加失败');
            console.log(res.data.success);
          }
        }).catch(function (err) {
          console.log(err);
        })

      }
    }
    ,
    mounted() {
      this.findallcustomers()
    }
  }
</script>

<style scoped>

</style>
