<template>
  <el-container>
    <el-header>
      <h2>在售类目管理</h2>
    </el-header>
    <el-main>
      <div>
        <el-table
          :data="showdata.filter(data => !search || data.cname.toLowerCase().includes(search.toLowerCase())).slice((currentPage-1)*pagesize,currentPage*pagesize)"
          style="width: 100%">
          <el-table-column
            label="名字"
            prop="cname">
          </el-table-column>
          <el-table-column
            label="价格"
            prop="price">
          </el-table-column>
          <el-table-column
            label="描述"
            prop="description">
          </el-table-column>
          <el-table-column
            label="图片">
            <template slot-scope="scope">
              <el-image style="width: 50px; height: 50px" :src="scope.row.link" fit="fill"></el-image>
            </template>
          </el-table-column>
          <el-table-column
            label="类目名称"
            prop="categoryname">
          </el-table-column>
          <el-table-column
            label="图片链接"
            prop="link">
          </el-table-column>
          <el-table-column
            label="库存"
            prop="stock">
          </el-table-column>
          <el-table-column
            align="right">
            <template slot="header" slot-scope="scope">
              <el-input
                v-model="search"
                size="mini"
                placeholder="输入菜名搜索"/>
            </template>
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleReset(scope.$index, scope.row.commodityid)">修改信息
              </el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row.commodityid)">下架
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
    <el-dialog title="菜品信息修改" :visible.sync="dialogFormVisible_1">
      <el-form :model="reSetForm" :rules="rules" ref="reSetForm">
        <el-form-item label="菜品id" :label-width="formLabelWidth">
          <el-input v-model="reSetForm.commodityid" autocomplete="off" :disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="名字" :label-width="formLabelWidth" prop="cname">
          <el-input v-model="reSetForm.cname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="价格" :label-width="formLabelWidth" prop="cname">
          <el-input v-model="reSetForm.price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="描述" :label-width="formLabelWidth" prop="description">
          <el-input v-model="reSetForm.description" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="类目名称" prop="categoryid">
          <el-select v-model="reSetForm.categoryid" placeholder="请选择菜品类别">
            <el-option :label="item.cname" :value="item.ctype" v-for="item in category" :key="item.ctype"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="链接" :label-width="formLabelWidth" prop="link">
          <el-input v-model="reSetForm.link" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="库存" :label-width="formLabelWidth" prop="stock">
          <el-input v-model="reSetForm.stock" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_1">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="菜品信息添加" :visible.sync="dialogFormVisible_2">
      <el-form :model="newCommodityForm" :rules="rules" ref="newCommodityForm">
        <el-form-item label="名字" :label-width="formLabelWidth" prop="cname">
          <el-input v-model=" newCommodityForm.cname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="价格" :label-width="formLabelWidth" prop="price">
          <el-input v-model=" newCommodityForm.price" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="描述" :label-width="formLabelWidth" prop="description">
          <el-input v-model=" newCommodityForm.description" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="类目名称" prop="categoryid">
          <el-select v-model="newCommodityForm.categoryid" placeholder="请选择菜品类别">
            <el-option :label="item.cname" :value="item.ctype" v-for="item in category" :key="item.ctype"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="链接" :label-width="formLabelWidth" prop="link">
          <el-input v-model=" newCommodityForm.link" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="库存" :label-width="formLabelWidth" prop="stock">
          <el-input v-model.number=" newCommodityForm.stock" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible_1 = false">取 消</el-button>
        <el-button type="primary" @click="dialogConfirmed_2">确 定</el-button>
      </div>
    </el-dialog>
    <el-button type="primary" style="margin-top: 20px;width: 100px" size="mini" @click="dialogFormVisible_2=true">
      添加菜品
    </el-button>
  </el-container>
</template>
<script>
  export default {
    name: "onsellCommodity",
    data() {
      return {
        currentPage: 1, //初始页
        pagesize: 5,    //    每页的数据
        showdata: [],
        category: [],
        search: '',
        dialogFormVisible_1: false,
        dialogFormVisible_2: false,
        formLabelWidth: '120px',
        reSetForm: {
          commodityid: '',
          cname: '',
          price: '',
          description: '',
          categoryid: '',
          categoryname: '',
          link: '',
          stock: '',
          whetheronsell: ''

        },
        newCommodityForm: {
          commodityid: '',
          cname: '',
          price: '',
          description: '',
          categoryid: '',
          categoryname: '',
          link: '',
          stock: '',
          whetheronsell: 'true'

        },
        rules: {
          cname: [
            {required: true, message: '请输入名称', trigger: 'blur'},
          ],
          price: [
            {required: true, message: '请输入价格', trigger: 'blur'},
          ],
          description: [
            {required: true, message: '请输入描述', trigger: 'blur'},
          ],
          categoryid: [
            {required: true, message: '请输入类别', trigger: 'blur'},
          ],
          link: [
            {required: true, message: '请输入链接', trigger: 'blur'},
          ],
          stock: [
            {required: true, message: '请输入库存', trigger: 'blur'},
          ],
        }
      };

    },
    methods: {
      dialogConfirmed_2() {
        let _this = this;
        for (let i = 0; i < _this.category.length; i++) {
          if (_this.category[i].ctype === _this.newCommodityForm.categoryid) {
            _this.newCommodityForm.categoryname = _this.category[i].cname
          }
        }
        _this.$http.post("http://localhost:8989/saveCommodity", _this.newCommodityForm).then(function (res) {
          console.log(res);
          if (res.data.success) {
            //refresh
            _this.findAll();
            _this.dialogFormVisible_2 = false;
            _this.newCommodityForm = {whetheronsell: 'true'};
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
        for (let i = 0; i < _this.category.length; i++) {
          if (_this.category[i].ctype === _this.reSetForm.categoryid) {
            _this.reSetForm.categoryname = _this.category[i].cname
          }
        }
        console.log(_this.reSetForm);
        this.$http.post("http://localhost:8989/updateCommodity", _this.reSetForm).then(function (res) {
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
      handleDelete(index, commodityid) {
        console.log(index, commodityid);
        let _this = this;
        this.$http.post("http://localhost:8989/toselloutCommodity", {params_1: commodityid}).then(function (res) {
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
      handleReset(index, ctype) {
        let _this = this;
        this.$http.post("http://localhost:8989/findCommodityById", {params_1: ctype}).then(function (res) {
          _this.reSetForm = res.data[0];
          _this.dialogFormVisible_1 = true;
        }).catch(function (err) {
          console.log(err);
        })
      }
      ,
      findAll() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllonsellCommodity').then(function (res) {
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
      },
      findAllCategory() {
        let _this = this;
        this.$http.get('http://localhost:8989/findAllCategory').then(function (res) {
          console.log(res);
          _this.category = res.data;
        }).catch(function (err) {
          console.log(err);
        })
      }
    },
    created() {
      this.findAll();
      this.findAllCategory();
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
