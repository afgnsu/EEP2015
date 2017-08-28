using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT205
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

        public string getFix()
        {
            return string.Format("{0:yyMMdd}", DateTime.Now.Date);
        }

        public object[] smRT2055(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTFaqM WHERE caseno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();
                selectSql = "select * FROM RTSndWork WHERE linkno='" + sdata[0] + "' and (worktype ='01' or worktype ='09') and canceldat is null and finishdat is null ";
                cmd.CommandText = selectSql;
                DataSet yy = cmd.ExecuteDataSet();

                if (yy.Tables[0].Rows.Count > 0)
                {
                    return new object[] { 0, "���u��|�����u�A�L�k����!!" };
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "�ȶD��w�@�o�A���൲�סC" };
                    }
                    if (ds.Tables[0].Rows[0]["closedat"].ToString() != "")
                    {
                        return new object[] { 0, "�Фŭ��е��סC" };
                    }
                }

                /*���o�έp�����G�A�ñN���G��^*/
                selectSql = " update RTFaqM set closedat=getdate(),closeusr='" + sdata[1] + "' WHERE caseno='" + sdata[0] + "' ";
                cmd.CommandText = selectSql;
                double ii = cmd.ExecuteNonQuery();
                return new object[] { 0, "�ȶD�浲�צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȶD��@�o�@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT2056(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTFaqM WHERE caseno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "�ȶD��w�@�o�A�������C" };
                    }
                    if (ds.Tables[0].Rows[0]["closedat"].ToString() != "" && ds.Tables[0].Rows[0]["closeusr"].ToString() != sdata[1])
                    {
                        return new object[] { 0, "�Ȧ��쵲�פH�i���হ�ȶD��A���ॢ�� !!"+ ds.Tables[0].Rows[0]["closeusr"].ToString() };
                    }
                    if (ds.Tables[0].Rows[0]["closedat"].ToString() == "")
                    {
                        return new object[] { 0, "�ȶD��|�����סA�������C" };
                    }
                }

                /*���o�έp�����G�A�ñN���G��^*/
                selectSql = " update RTFaqM set closedat=null,closeusr='' WHERE caseno='" + sdata[0] + "' ";
                cmd.CommandText = selectSql;
                double ii = cmd.ExecuteNonQuery();
                return new object[] { 0, "�ȶD����ন�\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȶD�����@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT2057(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTFaqM WHERE caseno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "�ȶD��w�@�o�A���i���а���C" };
                    }
                }

                /*���o�έp�����G�A�ñN���G��^*/
                selectSql = " update RTFaqM set canceldat=getdate(),cancelusr='" + sdata[1] + "' WHERE caseno='" + sdata[0] + "' ";
                cmd.CommandText = selectSql;
                double ii = cmd.ExecuteNonQuery();
                selectSql = " update RTSndWork set canceldat=getdate(),cancelusr='" + sdata[1] + "', memo = memo+' [�]�ȶD��@�o�Ө������u��]' WHERE linkno='" + sdata[0] + "' and (worktype ='01' or worktype ='09') and canceldat is null ";
                cmd.CommandText = selectSql;
                ii = cmd.ExecuteNonQuery();
                return new object[] { 0, "�ȶD��@�o���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����ȶD��@�o�@�~,���~�T���G" + ex };
            }
        }
    }
}
