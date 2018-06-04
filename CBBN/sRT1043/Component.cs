using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1043
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
        public object[] smRT10431(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10431.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10431.InfoParameters[0].Value = sdata[0];
                cmdRT10431.InfoParameters[1].Value = sdata[1];
                cmdRT10431.InfoParameters[2].Value = sdata[2];
                cmdRT10431.InfoParameters[3].Value = sdata[3];
                cmdRT10431.InfoParameters[4].Value = sdata[4];
                cmdRT10431.InfoParameters[5].Value = sdata[5];
                cmdRT10431.InfoParameters[6].Value = sdata[6];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10431.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10432(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10432.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10432.InfoParameters[0].Value = sdata[0];
                cmdRT10432.InfoParameters[1].Value = sdata[1];
                cmdRT10432.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10432.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10433(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10433.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10433.InfoParameters[0].Value = sdata[0];
                cmdRT10433.InfoParameters[1].Value = sdata[1];
                cmdRT10433.InfoParameters[2].Value = sdata[2];
                cmdRT10433.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10433.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10434(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10434.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10434.InfoParameters[0].Value = sdata[0];
                cmdRT10434.InfoParameters[1].Value = sdata[1];
                cmdRT10434.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10434.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10435(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10435.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10435.InfoParameters[0].Value = sdata[0];
                cmdRT10435.InfoParameters[1].Value = sdata[1];
                cmdRT10435.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10435.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10436(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10436.Connection;
            conn.Open();
            string selectSql, sqlxx, sqlYY, sqlzz;
            DataSet rsyy, RSXX, RSzz;
            sqlxx = "select * FROM RTLessorAVSCustCont WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            sqlYY = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "' ";
            sqlzz = "select count(*) as cnt FROM RTLessorAVSCUSTcontsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and dropdat is null and unclosedat is null and closedat is null ";
            selectSql = " select * FROM RTLessorAVSCustCont WHERE  CUSID='" + sdata[0] + "' AND entryno = " + sdata[1];
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            rsyy = cmd.ExecuteDataSet();
            cmd.CommandText = sqlzz;
            RSzz = cmd.ExecuteDataSet();

            
            if (rsyy.Tables[0].Rows.Count <= 0)
            {
                return new object[] { 0, "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "����Ƥw�@�o�ɡA���i�������������ק@�~�C" };
                }

                if (RSXX.Tables[0].Rows[0]["strbillingdat"].ToString() == "")
                {
                    return new object[] { 0, "�}�l�p�O��ťծɤ��i���������ק@�~�C" };
                }
              
                if (RSXX.Tables[0].Rows[0]["batchno"].ToString() != "" || RSXX.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "���������Ƥw�������b�ڡA���i���Ʋ��͡C" };
                }

                if (rsyy.Tables[0].Rows.Count > 0)
                {
                    if (rsyy.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ƥw�@�o�A�����@�o����@�~�C" };
                    }

                    if (rsyy.Tables[0].Rows[0]["DROPdat"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ƥw�h���A�����@�o�����ơC" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�����D�ɸ�ơA�L�k������������b�ڵ��ק@�~�C" };
            }

            if (RSzz.Tables[0].Rows.Count <= 0)
            {
                if (Convert.ToInt32(RSzz.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                return new object[] { 0, "�������Ƥw�s�b���ڬ��u��A�����Ѭ��u��i�浲�ק@�~�C" };
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10436.InfoParameters[0].Value = sdata[0];
                cmdRT10436.InfoParameters[1].Value = sdata[1];
                cmdRT10436.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10436.ExecuteNonQuery();
                return new object[] { 0, "�Τ�����������b�ڦ��\ "};
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�����������b�ڧ@�~,���~�T��" + ex.Message };
            }
        }

        public object[] smRT10437(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            string BATCHNOXX = "";
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10437.Connection;
            conn.Open();
            string selectSql = "select max(entryno)as entryno from RTLessorAVSCUSTlog where CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet RSXX = cmd.ExecuteDataSet();
            int xxmaxentryno;

            if (RSXX.Tables[0].Rows.Count <= 0)
            {
                xxmaxentryno = 0;
            }
            else
            {
                xxmaxentryno = Convert.ToInt32(RSXX.Tables[0].Rows[0]["entryno"].ToString());
            }

            selectSql = " select * FROM RTLessorAVSCustCont WHERE  CUSID='" + sdata[0] + "' AND entryno = " + sdata[1];
            cmd.CommandText = selectSql;
            RSXX = cmd.ExecuteDataSet();

            selectSql = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet rsyy = cmd.ExecuteDataSet();

            if (rsyy.Tables[0].Rows.Count <= 0)
            {
                return new object[] { 0, "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "����Ƥw�@�o�ɡA���i��������������ק@�~�C" };
                }

                /*
                if (RSXX.Tables[0].Rows[0]["paytype"].ToString() == "02")
                {
                    return new object[] { 0, "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u�沣�������b�ڡC" };
                }
                */

                if (RSXX.Tables[0].Rows[0]["batchno"].ToString() == "" || RSXX.Tables[0].Rows[0]["FINISHDAT"].ToString() == "")
                {
                    return new object[] { 0, "batchno���ťթε��פ鬰�ťծɡA��ܦ��������Ʃ|���������b�ڡA���i�������@�~�C" };
                }

                BATCHNOXX = RSXX.Tables[0].Rows[0]["batchno"].ToString();

                if (rsyy.Tables[0].Rows.Count > 0)
                {
                    if (rsyy.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ƥw�@�o�A���i��������������ק@�~�C" };
                    }

                    if (rsyy.Tables[0].Rows[0]["DROPdat"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ʃ|���h���A���i��������������ק@�~�C" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�����D�ɸ�ơA�L�k������������b�ڵ��ק@�~�C" };
            }

            string sqlyy = "select * FROM RTLessorAVSCUSTAR WHERE CUSID='" + sdata[0] + "' AND BATCHNO='" + BATCHNOXX + "'";
            cmd.CommandText = sqlyy;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["mdat"].ToString() != "" && Convert.ToInt32(RSXX.Tables[0].Rows[0]["REALAMT"].ToString()) > 0)
                {
                    return new object[] { 0, "�����b�ڤw�R�b���i���ת���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10437.InfoParameters[0].Value = sdata[0];
                cmdRT10437.InfoParameters[1].Value = sdata[1];
                cmdRT10437.InfoParameters[2].Value = sdata[2];
                cmdRT10437.InfoParameters[3].Value = BATCHNOXX;
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10437.ExecuteNonQuery();
                return new object[] { 0, "�Τ�������������b�ڦ��\ " };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�������������b�ڧ@�~,���~�T��" + ex.Message };
            }
        }

        public object[] smRT10438(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');            
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10438.Connection;
            conn.Open();
            string selectSql = " select * FROM RTLessorAVSCUSTCONT WHERE CUSID='" + sdata[0] + "' AND entryno = " + sdata[1];
            cmd.CommandText = selectSql;
            DataSet RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["finishDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ������Ƥw���סA���i�@�o�C(�Ч�ε��ת���)�C" };
                }

                
                if (RSXX.Tables[0].Rows[0]["batchno"].ToString() != "")
                {
                    return new object[] { 0, "���Τ������Ƥw�������b�ڡA���i�@�o�C" };
                }
                

                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ������Ƥw�@�o�A���i���а���C" };
                }

            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�����D�ɸ�ơA�L�k����@�o�@�~�C" };
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10438.InfoParameters[0].Value = sdata[0];
                cmdRT10438.InfoParameters[1].Value = sdata[1];
                cmdRT10438.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10438.ExecuteNonQuery();
                return new object[] { 0, "�Τ������Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ������Ƨ@�o�@�~,���~�T��" + ex.Message };
            }
        }

        public object[] smRT10439(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10439.Connection;
            conn.Open();
            string selectSql = " select * FROM RTLessorAVSCUSTCONT WHERE CUSID='" + sdata[0] + "' AND entryno = " + sdata[1];
            cmd.CommandText = selectSql;
            DataSet RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "���Τ������Ʃ|���@�o�A���i����C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�����D�ɸ�ơA�L�k����@�o����@�~�C" };
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10439.InfoParameters[0].Value = sdata[0];
                cmdRT10439.InfoParameters[1].Value = sdata[1];
                cmdRT10439.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10439.ExecuteNonQuery();
                return new object[] { 0, "�Τ������Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ������Ƨ@�o�@�~,���~�T��" + ex.Message };
            }
        }
    }
}
