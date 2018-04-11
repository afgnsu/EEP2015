using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;
using System.Data.OleDb;

namespace sRT1041
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

        public object[] smRT1041(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1041.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1041.InfoParameters[0].Value = sdata[0];
                cmdRT1041.InfoParameters[1].Value = sdata[1];
                cmdRT1041.InfoParameters[2].Value = sdata[2];
                cmdRT1041.InfoParameters[3].Value = sdata[3];
                cmdRT1041.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1041.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT1043(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            double iseq = 0;
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            string selectSql = " select max(entryno) as entryno FROM RTLessorAVSCustRepair WHERE CUSID='" + sdata[0] + "'";
            
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows[0]["entryno"].ToString() != "")
            {
                iseq = Int32.Parse(ds.Tables[0].Rows[0]["entryno"].ToString())+1;
            }
            else
            {
                iseq = 1;
            }
                //�]�w��J�Ѽƪ���
            try
            {
                
                /*���o�έp�����G�A�ñN���G��^*/
                double ii =iseq;
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT104111(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT104111.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT104111.InfoParameters[0].Value = sdata[0];
                cmdRT104111.InfoParameters[1].Value = sdata[1];
                cmdRT104111.InfoParameters[2].Value = sdata[2];
                cmdRT104111.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT104111.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT104112(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT1041121.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT1041121.InfoParameters[0].Value = sdata[0];
                cmdRT1041121.InfoParameters[1].Value = sdata[1];
                cmdRT1041121.InfoParameters[2].Value = sdata[2];
                cmdRT1041121.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT1041121.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }
    }
}
