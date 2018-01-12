using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT104
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
            return string.Format("E{0:yyMMdd}", DateTime.Now.Date);
        }

        //�Τ�@�o
        public object[] smRT104B(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT104B.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUST WHERE comq1=" + sdata[0] + " and lineq1 = "+ sdata[1] + " and CUSID ='" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            if (ds.Tables[0].Rows.Count > 0)
            {                
                if (ds.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�w���u�A���i�@�o�C" };
                }
                if (ds.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�w�@�o�A���i���а���C" };
                }
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT104B.InfoParameters[0].Value = sdata[0];
                cmdRT104B.InfoParameters[1].Value = sdata[1];
                cmdRT104B.InfoParameters[2].Value = sdata[2];
                cmdRT104B.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT104B.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ӽЧ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ӽЧ@�o�@�~,���~�T��" + ex };
            }
        }

        //�Τ�@�o���� 
        public object[] smRT104C(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT104C.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCUST WHERE comq1=" + sdata[0] + " and lineq1 = " + sdata[1] + " and CUSID ='" + sdata[2] + "'";
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();

            if (ds.Tables[0].Rows.Count > 0)
            {
                string ss1 = ds.Tables[0].Rows[0]["CANCELDAT"].ToString();
                if (ss1 == "")
                {
                    return new object[] { 0, "���Τ�|���@�o�A���i�@�o����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT104C.InfoParameters[0].Value = sdata[0];
                cmdRT104C.InfoParameters[1].Value = sdata[1];
                cmdRT104C.InfoParameters[2].Value = sdata[2];
                cmdRT104C.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT104C.ExecuteNonQuery();
                return new object[] { 0, "�Τ�ӽЧ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�ӽЧ@�o�@�~,���~�T��" + ex };
            }
        }

        private void ucRTLessorAVSCust_BeforeModify(object sender, UpdateComponentBeforeModifyEventArgs e)
        {
            //���o�O�Ҫ��Ǹ� �H�� ������
            string sgtserial = ucRTLessorAVSCust.GetFieldOldValue("GTSERIAL").ToString();
            string sDOCKETDAT  = ucRTLessorAVSCust.GetFieldOldValue("DOCKETDAT").ToString();
            string ss = "";
            if (sgtserial== "" && sDOCKETDAT!="")
            {
                string ssql = " select isnull(max(gtserial),'') as maxgtserial from RTlessoravsCust where gtserial <> '' and substring(gtserial, 1,3) = 'AVS' ";

                //�}�Ҹ�Ƴs��
                IDbConnection conn = cmdRT104C.Connection;
                conn.Open();
                cmd.CommandText = ssql;
                DataSet ds = cmd.ExecuteDataSet();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string ss1 = ds.Tables[0].Rows[0]["maxgtserial"].ToString();
                    if (ss1 == "")
                    {
                        ss = "AVS000000001";
                    }
                    else
                    {
                        ss = "00000000" + (Convert.ToInt32((ss1.Substring(3, 9)) + 1).ToString());
                        ss = "AVS" + ss.Substring(ss.Length-9, 9);
                    }
                }
                ucRTLessorAVSCust.SetFieldValue("GTSERIAL", ss);
            }
        }

        private void ucRTLessorAVSCust_BeforeInsert(object sender, UpdateComponentBeforeInsertEventArgs e)
        {
            //���o�O�Ҫ��Ǹ� �H�� ������
            string sgtserial = ucRTLessorAVSCust.GetFieldCurrentValue("GTSERIAL").ToString();
            string sDOCKETDAT = ucRTLessorAVSCust.GetFieldCurrentValue("DOCKETDAT").ToString();
            string ss = "";
            if (sgtserial == "" && sDOCKETDAT != "")
            {
                string ssql = " select isnull(max(gtserial),'') as maxgtserial from RTlessoravsCust where gtserial <> '' and substring(gtserial, 1,3) = 'AVS' ";

                //�}�Ҹ�Ƴs��
                IDbConnection conn = cmdRT104C.Connection;
                conn.Open();
                cmd.CommandText = ssql;
                DataSet ds = cmd.ExecuteDataSet();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string ss1 = ds.Tables[0].Rows[0]["maxgtserial"].ToString();
                    if (ss1 == "")
                    {
                        ss = "AVS000000001";
                    }
                    else
                    {
                        ss = "00000000" + (Convert.ToInt32((ss1.Substring(3, 9)) + 1).ToString());
                        ss = "AVS" + ss.Substring(ss.Length - 9, 9);
                    }
                }
                ucRTLessorAVSCust.SetFieldValue("GTSERIAL", ss);
            }
        }    
    }
}
