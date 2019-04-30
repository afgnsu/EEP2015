using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1044
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
            return string.Format("EM{0:yyMMdd}", DateTime.Now.Date);
        }

        public object[] smRT10441(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10441.Connection;
            conn.Open();

            string selectSql, sqlxx, sqlYY, sqlzz;
            string tempperiod = "";
            string temprcvmoney = "";
            string temppaytype = "";
            string tempcardno = "";
            DataSet rsyy, RSXX, RSzz;
            sqlxx = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            sqlYY = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "' ";
            sqlzz = "select count(*) as cnt FROM RTLessorAVSCustReturnHardware WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and dropdat is null and rcvfinishdat is null ";
            selectSql = " select * FROM RTLessorAVSCustReturn WHERE  CUSID='" + sdata[0] + "' AND entryno = " + sdata[1];
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
                    return new object[] { 0, "�����_����Ƥw�������b�ڡA���i���Ʋ��͡C" };
                }

                if (rsyy.Tables[0].Rows.Count > 0)
                {
                    if (rsyy.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ�w�h���Χ@�o�A�L�k����(���u�楲���@�o)�C" };
                    }

                    if (rsyy.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                    {
                        return new object[] { 0, "�Ȥ᥼�h���A���i����_���@�~(�����Ĵ_���@�~)�C" };
                    }
                }

                 tempperiod = RSXX.Tables[0].Rows[0]["period"].ToString();
                 temprcvmoney = RSXX.Tables[0].Rows[0]["amt"].ToString(); 
                 temppaytype = RSXX.Tables[0].Rows[0]["paytype"].ToString();
                 tempcardno = RSXX.Tables[0].Rows[0]["CREDITCARDNO"].ToString(); 

            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�_���D�ɸ�ơA�L�k������������b�ڵ��ק@�~�C" };
            }

            if (RSzz.Tables[0].Rows.Count <= 0)
            {
                if (Convert.ToInt32(RSzz.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                    return new object[] { 0, "�����ڬ��u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{��(����Ωλ�Υ�����)�A���i���槹�u���ק@�~�C" };
            }

            sqlxx = "select * FROM RTLessorAVSCustReturnsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            //��w�@�o�ɡA���i���槹�u���שΥ����u����
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u����" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSXX.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����ڬ��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["REALENGINEER"].ToString() == "" && RSXX.Tables[0].Rows[0]["REALCONSIGNEE"].ToString() == "")
                {
                    return new object[] { 0, "�����ڬ��u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P�ӡC" };
                }

                if (RSXX.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "" || RSXX.Tables[0].Rows[0]["STOCKCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "�����ڬ��u��w�뵲�A���i���ʡC" };
                }

                if (RSXX.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "�����ڬ��u��w���������b���ɡA���i���ư���(�Ь���T��)�C" };
                }
            }


            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10441.InfoParameters[0].Value = sdata[0];
                cmdRT10441.InfoParameters[1].Value = sdata[1];
                cmdRT10441.InfoParameters[2].Value = sdata[2];
                cmdRT10441.InfoParameters[3].Value = sdata[3];
                cmdRT10441.InfoParameters[4].Value = tempperiod;
                cmdRT10441.InfoParameters[5].Value = temprcvmoney;
                cmdRT10441.InfoParameters[6].Value = temppaytype;
                cmdRT10441.InfoParameters[7].Value = tempcardno;
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10441.ExecuteNonQuery();
                return new object[] { 0, "�Τ᦬�ڬ��u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���榬�ڬ��u�槹�u���ק@�~,���~�T��"+ ex };
            }
        }

        public object[] smRT10442(object[] objParam)
        {
            //������������
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10442.Connection;
            conn.Open();

            string sqlxx, sqlyy;
            DataSet RSyy, RSXX;
            sqlxx = "select * FROM RTLessorAVSCustReturnsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            sqlyy = "select count(*) as cnt FROM RTLessorAVSCustReturnhardware WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and dropdat is null and RCVPRTNO <> ''  ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            RSyy = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSXX.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����ڬ��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "" || RSXX.Tables[0].Rows[0]["STOCKCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "�����ڬ��u��w���ͪ��~��γ�A�Х������γ�~����楼���u���ק@�~�C" };
                }

                if (RSyy.Tables[0].Rows.Count <= 0)
                {
                    if (Convert.ToInt32(RSyy.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                        return new object[] { 0, "�����ڬ��u��w�뵲�A���i���ʡC" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10442.InfoParameters[0].Value = sdata[0];
                cmdRT10442.InfoParameters[1].Value = sdata[1];
                cmdRT10442.InfoParameters[2].Value = sdata[2];
                cmdRT10442.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10442.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_�����ڬ��u�楼���u���צ��\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����_�����ڬ��u�楼���u���ק@�~,���~�T��,���~�T���G" + ex };
            }
        }

        public object[] smRT10443(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10443.Connection;
            conn.Open();

            string sqlxx, sqlyy;
            string tempperiod = "";
            string temprcvmoney = "";
            string temppaytype = "";
            string tempcardno = "";
            string BATCHNOXX = "";
            int xxmaxentryno = 0;
            DataSet RSyy, RSXX;
            sqlxx = "select * FROM RTLessorAVSCUST WHERE CUSID='" + sdata[0] + "' ";
            sqlyy = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            RSyy = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["cancelDAT"].ToString() != "")
                {
                    return new object[] { 0, "�Ȥ�w�@�o,���i����C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ���ɡA�L�k����C" };

            }

            if (RSyy.Tables[0].Rows.Count > 0)
            {
                if (RSyy.Tables[0].Rows[0]["cancelDAT"].ToString() != "")
                {
                    return new object[] { 0, "�Ȥ�_����Ƥw�@�o,���i����C" };
                }

                tempperiod = RSyy.Tables[0].Rows[0]["period"].ToString();
                temprcvmoney = RSyy.Tables[0].Rows[0]["amt"].ToString();
                temppaytype = RSyy.Tables[0].Rows[0]["paytype"].ToString();
                tempcardno = RSyy.Tables[0].Rows[0]["CREDITCARDNO"].ToString();

                //�O���Ȥ�D�ɲ����ɪ����ʶ����̤j��(�Y���u�浲�׮ɤw�O�������ʶ����p��ثe���̤j�ȮɡA��ܤw�g���䥦���ʵo�͡A�h�����\����C
                sqlyy = "select max(entryno)as entryno from RTLessorAVSCUSTlog where CUSID='" + sdata[0] + "' ";
                cmd.CommandText = sqlyy;
                RSyy = cmd.ExecuteDataSet();
                if (RSyy.Tables[0].Rows.Count > 0)
                {
                    xxmaxentryno = (Convert.ToInt32(RSyy.Tables[0].Rows[0]["entryno"].ToString()));
                }
                else
                {
                    xxmaxentryno = 0;
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�_����ơA�L�k����C" };
            }

            sqlxx = "select * FROM RTLessorAVSCustReturnsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                //�ˬd�����b���ɬO�_�w�R�b
                BATCHNOXX = RSXX.Tables[0].Rows[0]["BATCHNO"].ToString();
                sqlyy = "select * FROM RTLessorAVSCUSTAR WHERE CUSID='" + sdata[0] + "' and BATCHNO='" + BATCHNOXX + "'";
                cmd.CommandText = sqlyy;
                RSyy = cmd.ExecuteDataSet();
                if (RSyy.Tables[0].Rows.Count > 0)
                {
                    if (RSyy.Tables[0].Rows[0]["mdat"].ToString() != "" || (Convert.ToInt32(RSyy.Tables[0].Rows[0]["REALAMT"].ToString())) > 0)
                    {
                        return new object[] { 0, "�����b�ڤw�R�b�A���i���浲�ת���@�~(�лP��T���sô)�C" };
                    }                    
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() == "" && RSXX.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����u��|�����סA���i���浲�ת���@�~�C" };
                }

                if (RSXX.Tables[0].Rows[0]["dropdat"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w�@�o�A���i����C" };
                }

                if (xxmaxentryno > (Convert.ToInt32(RSXX.Tables[0].Rows[0]["maxentryno"].ToString())))
                {
                    return new object[] { 0, "�Ȥ�D�ɤw�i��䥦���ʡA�]���L�k���欣�u�����@�~�C" };
                }
            }
            

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10443.InfoParameters[0].Value = sdata[0];
                cmdRT10443.InfoParameters[1].Value = sdata[1];
                cmdRT10443.InfoParameters[2].Value = sdata[2];
                cmdRT10443.InfoParameters[3].Value = sdata[3];
                cmdRT10443.InfoParameters[4].Value = BATCHNOXX;
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10443.ExecuteNonQuery();
                return new object[] { 0, "�Τ᦬�ڬ��u�浲�ת��ন�\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���榬�ڬ��u�槹�u���ק@�~,���~�T��"+ex };
            }
        }

        public object[] smRT10444(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10444.Connection;
            conn.Open();

            string sqlxx, sqlyy;
            DataSet RSyy, RSXX;
            sqlxx = "select * FROM RTLessorAVSCUSTReturnsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            sqlyy = "select * FROM RTLessorAVSCustRCVHardware WHERE prtno='" + sdata[2] + "' and canceldat is null ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            RSyy = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSXX.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���_�����ڬ��u��w���u(�����u)���סA���i�@�o(���@�o�Х��M���˾����u��)�C" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "���_�����ڬ��u��w�@�o�A���i���а���@�o�@�~�C" };
                }
            }

            if (RSyy.Tables[0].Rows.Count > 0)
            {
               return new object[] { 0, "�����u��w���ͪ��~��γ�A���i�����@�o(�Х����ફ�~��γ�)�C" };
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10444.InfoParameters[0].Value = sdata[0];
                cmdRT10444.InfoParameters[1].Value = sdata[1];
                cmdRT10444.InfoParameters[2].Value = sdata[2];
                cmdRT10444.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10444.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_�����ڬ��u��@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����_�����ڬ��u��@�o�@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT10445(object[] objParam)
        {
            //�@�o����
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10445.Connection;
            conn.Open();
            string sqlxx;
            DataSet RSXX;
            sqlxx = "select * FROM RTLessorAVSCUSTReturnsndwork WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1] + " and prtno='" + sdata[2] + "' ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["dropdat"].ToString() == "" || RSXX.Tables[0].Rows[0]["dropdat"].ToString() == "")
                {
                    return new object[] { 0, "���Τ�_�����ڬ��u��|���@�o�A���i����@�o����@�~�C" };
                }

                if (RSXX.Tables[0].Rows[0]["bonuscloseym"].ToString() != "")
                {
                    return new object[] { 0, "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10445.InfoParameters[0].Value = sdata[0];
                cmdRT10445.InfoParameters[1].Value = sdata[1];
                cmdRT10445.InfoParameters[2].Value = sdata[2];
                cmdRT10445.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10445.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_�����ڬ��u��@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�_�����ڬ��u��@�o����@�~,���~�T���G" + ex };
            }
        }

        public object[] smRT10446(object[] objParam)
        {
            //����������
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10446.Connection;
            conn.Open();
            string sqlxx, sqlYY, sqlzz;
            DataSet rsyy, RSXX, RSzz;

            sqlxx = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            sqlYY = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = sqlYY;
            rsyy = cmd.ExecuteDataSet();
            sqlzz = "select count(*) as cnt FROM RTLessorAVSCustReturnsndwork  WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1] + " and dropdat is null and unclosedat is null and closedat is null ";
            cmd.CommandText = sqlzz;
            RSzz = cmd.ExecuteDataSet();

            if (rsyy.Tables[0].Rows.Count <= 0)
            {
                return new object[] { 0, "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["canceldat"].ToString() != "")
                {
                    return new object[] { 0, "��_����Ƥw�@�o�ɡA���i�����������b�ڧ@�~�C" };
                }

                if (RSXX.Tables[0].Rows[0]["strbillingdat"].ToString() == "")
                {
                    return new object[] { 0, "�}�l�p�O��ťծɤ��i���������ק@�~�C" };
                }

                /*
                if (RSXX.Tables[0].Rows[0]["paytype"].ToString() == "02")
                {
                    return new object[] { 0, "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u�沣�������b�ڡC" };
                }
                */

                if (RSXX.Tables[0].Rows[0]["batchno"].ToString() != "" || RSXX.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����_����Ƥw�������b�ڡA���i���Ʋ��͡C" };
                }

                if (rsyy.Tables[0].Rows.Count > 0)
                {
                    if (rsyy.Tables[0].Rows[0]["canceldat"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ƥw�@�o�A�����@�o�_����ơC" };
                    }

                    if (rsyy.Tables[0].Rows[0]["DROPdat"].ToString() == "")
                    {
                        return new object[] { 0, "�Ȥ��Ʃ|���h���A���i����_���������b�ڧ@�~�C" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�_���D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (RSzz.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSzz.Tables[0].Rows[0]["cnt"].ToString()) > 0)
                {
                    return new object[] { 0, "���_����Ƥw�s�b���ڬ��u��A�����Ѭ��u��i�浲�ק@�~�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10446.InfoParameters[0].Value = sdata[0];
                cmdRT10446.InfoParameters[1].Value = sdata[1];
                cmdRT10446.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10446.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_���������b�ڦ��\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�_���������b�ڧ@�~,���~�T��"+ex.Message};
            }
        }

        public object[] smRT10447(object[] objParam)
        {
            //���������פ���
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            var BATCHNOXX = "";

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10447.Connection;
            conn.Open();
            string selectSql = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();

            if (ds1.Tables[0].Rows.Count <= 0)
            {
                return new object[] { 0, "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (ds.Tables[0].Rows.Count > 0)
            {
                BATCHNOXX = ds.Tables[0].Rows[0]["BATCHNO"].ToString();

                if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                {
                    return new object[] { 0, "��_����Ƥw�@�o�ɡA���i��������������ק@�~�C" };
                }

                if (ds.Tables[0].Rows[0]["strbillingdat"].ToString() == "")
                {
                    return new object[] { 0, "�}�l�p�O��ťծɤ��i���������ק@�~�C" };
                }

                //if (ds.Tables[0].Rows[0]["paytype"].ToString() == "02")
                //{
                //    return new object[] { 0, "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u����������b�ڡC" };
                //}

                if (ds.Tables[0].Rows[0]["batchno"].ToString() == "" || ds.Tables[0].Rows[0]["FINISHDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����_����Ʃ|���������b�ڡA���i�������@�~�C" };
                }

                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (ds1.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "��Ȥ��Ƨ@�o�ɡA���i��������������ק@�~�C" };
                    }

                    if (ds1.Tables[0].Rows[0]["DROPdat"].ToString() != "")
                    {
                        return new object[] { 0, "��Ȥ�w�h���ɡA���i��������������ק@�~�C" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�_���D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10447.InfoParameters[0].Value = sdata[0];
                cmdRT10447.InfoParameters[1].Value = sdata[1];
                cmdRT10447.InfoParameters[2].Value = sdata[2];
                cmdRT10447.InfoParameters[3].Value = BATCHNOXX;
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10447.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_�������������ק@�~���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�Τ�_�������������ק@�~���ѡC���~�T��:" +ex};
            }
        }

        public object[] smRT10448(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10448.Connection;
            conn.Open();

            string sqlxx;
            DataSet RSXX;
            sqlxx = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["finishDAT"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�_����Ƥw���סA���i�@�o�C(�Ч�ε��ת���)�C" };
                }

                if (RSXX.Tables[0].Rows[0]["batchno"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�_����Ƥw�������b�ڡA���i�@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                {
                    return new object[] { 0, "���Τ�_����Ƥw�@�o�A���i���а���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10448.InfoParameters[0].Value = sdata[0];
                cmdRT10448.InfoParameters[1].Value = sdata[1];
                cmdRT10448.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10448.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_����Ƨ@�o���\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�_����Ƨ@�o�@�~,���~�T��" + ex };
            }
        }

        public object[] smRT10449(object[] objParam)
        {//�@�o����
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10449.Connection;
            conn.Open();

            string sqlxx;
            DataSet RSXX;
            sqlxx = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and entryno=" + sdata[1];
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["canceldat"].ToString() == "")
                {
                    return new object[] { 0, "���Τ�_����Ʃ|���@�o�A���i����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10449.InfoParameters[0].Value = sdata[0];
                cmdRT10449.InfoParameters[1].Value = sdata[1];
                cmdRT10449.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10449.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_����Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����Τ�_����Ƨ@�o�@�~,���~�T��"+ ex };
            }
        }
    }
}
