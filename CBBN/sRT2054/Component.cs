using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT2054
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
            return string.Format("W{0:yyyyMMdd}", DateTime.Now.Date);
        }

        public object[] smRT20541(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTSndWork WHERE workno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "�ȶD���u�w�@�o�A���i���а���C" };
                    }
                }

                /*���o�έp�����G�A�ñN���G��^*/
                selectSql = " update RTSndWork set canceldat=getdate(),cancelusr='" + sdata[1]+ "' WHERE workno='" +sdata[0]+ "' ";
                cmd.CommandText = selectSql;
                double ii = cmd.ExecuteNonQuery();
                return new object[] { 0, "�ȶD���u�@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����l��@�o�@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT20543(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTSndWork WHERE workno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "���u��w�@�o�A���൲�סC" };
                    }

                    if (ds.Tables[0].Rows[0]["finishdat"].ToString() != "")
                    {
                        return new object[] { 0, "�Фŭ��Щ㧹�u�C" };
                    }

                    if (ds.Tables[0].Rows[0]["finisheng"].ToString() == "" && ds.Tables[0].Rows[0]["finishcons"].ToString() == "")
                    {
                        /*���o�έp�����G�A�ñN���G��^*/
                        selectSql = " update RTSndWork set finishdat=getdate(), finishusr='" + sdata[2] + "',finishtyp='" + sdata[1] + "', finisheng=assigneng, finishcons=assigncons WHERE workno='" + sdata[0] + "' ";
                    }
                    else
                    {
                        selectSql = " update RTSndWork set finishdat=getdate(),finishusr='" + sdata[2] + "',finishtyp='" + sdata[1] + "' WHERE workno='" + sdata[0] + "' ";
                    }
                    cmd.CommandText = selectSql;
                    double ii = cmd.ExecuteNonQuery();
                }

                /*���o�έp�����G�A�ñN���G��^*/
                if (sdata[3] == "Y")
                {
                    selectSql = " DELETE FROM RTSalesSch WHERE workno<>'' and workno ='" + sdata[0] + "' and canceldat is null ";
                    cmd.CommandText = selectSql;
                    double i1 = cmd.ExecuteNonQuery();

                    selectSql = " INSERT INTO RTSalesSch (SCHNO, COMTYPE, COMQ1, LINEQ1, "
                              + "  CUSID, ENTRYNO, WORKNO, DEALUSR, DEALDAT, UUSR,  "
                              + "  SCORE01, SCORE02, SCORE03, SCORE04, SCORE05, SCORE06, SCORE07, SCORE08, "
                              + "  SCORE09, SCORE10, SCORE11, SCORE12, SCORE13, SCORE14, SCORE15)  "
                              + "  SELECT c.maxschno, b.COMTYPE, b.COMQ1, b.LINEQ1, b.CUSID, b.ENTRYNO, a.WORKNO,  "
                              + "  a.FINISHENG, isnull(a.FINISHDAT, convert(datetime, convert(varchar(10), getdate(), 111))), a.FINISHENG,  "
                              + "  a.SCORE01, a.SCORE02, a.SCORE03, a.SCORE04, a.SCORE05, a.SCORE06, a.SCORE07, a.SCORE08,  "
                              + "  a.SCORE09, a.SCORE10, a.SCORE11, a.SCORE12, a.SCORE13, a.SCORE14, a.SCORE15 "
                              + "  FROM RTSndWork a "
                              + "  INNER JOIN RTFaqM b ON a.LINKNO = b.CASENO "
                              + "  inner join (select 'S' + left(convert(varchar(8), getdate(), 112), 6) + "
                              + "  isnull(right('000' + convert(varchar(4), convert(smallint, right(max(SCHNO), 4)) + 1), 4), '0001') as maxschno "
                              + "  from RTSalesSch where SCHNO like 'S' + left(convert(varchar(8), getdate(), 112), 6) + '%') c on 1 = 1  WHERE a.workno ='" + sdata[0] + "'  ";
                    cmd.CommandText = selectSql;
                    i1 = cmd.ExecuteNonQuery();
                }

                return new object[] { 0, "���u�浲�צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���欣�u��@�o�@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT20544(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmd.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                string selectSql = "select * FROM RTSndWork WHERE workno='" + sdata[0] + "'";
                cmd.CommandText = selectSql;
                DataSet ds = cmd.ExecuteDataSet();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["finishdat"].ToString() != "" && ds.Tables[0].Rows[0]["finishusr"].ToString() != sdata[1])
                    {
                        return new object[] { 0, "�Ȧ��짹�u�H�i���হ���u��A���ॢ�� !!" };
                    }

                    if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                    {
                        return new object[] { 0, "���u��w�@�o�A���൲�סC" };
                    }

                    if (ds.Tables[0].Rows[0]["finishdat"].ToString() == "")
                    {
                        return new object[] { 0, "���u��|���㧹�u�A�������C" };
                    }

                }

                /*���o�έp�����G�A�ñN���G��^*/
                selectSql = " update RTSndWork set finishdat=null,finishusr='',finishtyp='' WHERE workno='" + sdata[0] + "' ";
                cmd.CommandText = selectSql;
                double i1 = cmd.ExecuteNonQuery();
                return new object[] { 0, "���u����ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���欣�u�����@�~,���~�T���G" + ex };
            }
        }
    }
}
