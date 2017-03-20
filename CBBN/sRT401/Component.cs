using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.IO;
using System.Data;
using System.Data.OleDb;
using Newtonsoft;
using Newtonsoft.Json;
using Srvtools;
using System.Web;


namespace sRT401
{
    public partial class Component : DataModule
    {
        public Component()
        {
            InitializeComponent();
        }

        public Component(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }

        public object[] smRT401(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            var srcPath = @"..\JQWebClient\excel\" + sdata[0];
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT401.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                if (System.IO.File.Exists(srcPath))
                {
                    string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + srcPath + ";Extended Properties=Excel 8.0;";
                    OleDbConnection myConn = new System.Data.OleDb.OleDbConnection(strConn);
                    OleDbCommand myCommand = new System.Data.OleDb.OleDbCommand("SELECT * FROM [Sheet1$]", myConn);
                    OleDbDataAdapter myDA = new System.Data.OleDb.OleDbDataAdapter(myCommand);

                    DataSet myDS = new DataSet();
                    myDA.Fill(myDS);
                    /*���o�έp�����G�A�ñN���G��^*/
                    //cmdRT401.ExecuteDataSet();
                    return new object[] { 0, "�B�z���\" };
                }
                else
                {
                    return new object[] { 0, "�ɮפ��s�b" };
                }
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�B�z����"+ ex };
            }

        }
    }
}
