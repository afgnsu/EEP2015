using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Srvtools;
using System.Data;

namespace sRT1032
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

        //������
        public object[] smRT10321(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10321.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINEdrop WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i�������u��C" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�w���׮ɡA���i�������u��C" };
                }

                if (RSXX.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "")
                {
                    return new object[] { 0, "�w��������u��ɡA���i���а���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10321.InfoParameters[0].Value = sdata[0];
                cmdRT10321.InfoParameters[1].Value = sdata[1];
                cmdRT10321.InfoParameters[2].Value = sdata[2];
                cmdRT10321.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10321.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���������u�榨�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����M�u���������u��@�~,���~�T��" + ex };
            }
        }

        //�M�u����
        public object[] smRT10322(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10322.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtylinedrop WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "��M�u��Ƥw�@�o�ɡA���i���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "��M�u��Ƥw���׮ɡA���i���е��סC" };
                }

                if (RSXX.Tables[0].Rows[0]["SNDPRTNO"].ToString() == ""|| RSXX.Tables[0].Rows[0]["SNDWORKDAT"].ToString() == "")
                {
                    return new object[] { 0, "��M�u��Ʃ|�����ͩ�����u��ɡA���i���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "" || RSXX.Tables[0].Rows[0]["SNDCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "��M�u��Ƥ�������u��|�����׮ɡA���i���סC" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10322.InfoParameters[0].Value = sdata[0];
                cmdRT10322.InfoParameters[1].Value = sdata[1];
                cmdRT10322.InfoParameters[2].Value = sdata[2];
                cmdRT10322.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10322.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�M�u���u���ק@�~,���~�T��" + ex };
            }
        }

        //�@�@�@�o
        public object[] smRT10323(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10323.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtylinedrop WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "��M�u��Ƥw�@�o�ɡA���i���Ƨ@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "")
                {
                    return new object[] { 0, "��M�u��Ƥw���ͩ�����u��ɡA���i�@�o�C" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "��M�u��Ƥw���׮ɡA���i�@�o�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10323.InfoParameters[0].Value = sdata[0];
                cmdRT10323.InfoParameters[1].Value = sdata[1];
                cmdRT10323.InfoParameters[2].Value = sdata[2];
                cmdRT10323.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10323.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u��Ƨ@�o���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�M�u��Ƨ@�o�@�~,���~�T��" + ex };
            }
        }

        //�D�u����@�o����
        public object[] smRT10324(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10324.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtylinedrop WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " AND entryno=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() == "")
                {
                    return new object[] { 0, "���D�u�M�u��Ʃ|���@�o�A���i����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10324.InfoParameters[0].Value = sdata[0];
                cmdRT10324.InfoParameters[1].Value = sdata[1];
                cmdRT10324.InfoParameters[2].Value = sdata[2];
                cmdRT10324.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10324.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u��Ƨ@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�M�u��Ƨ@�o����@�~,���~�T���G" + ex };
            }
        }

        //�D�u�M�u���u�槹�u����
        public object[] smRT103213(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT103213.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINE WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1];
            string sqlyy = "select * FROM RTLessorAVSCmtyLineDROP WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " and ENTRYNO=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            DataSet RSYY = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�D�u�w�@�o�A�L�k����(���u�楲���@�o)�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��D�u���ɡA�L�k���סC" };
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u����ݺM�u���Ƥw�@�o�A���i���槹�u���ק@�~�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣�즹�M�u���u����ݺM�u���ơC" };

            }

            sqlxx = "select count(*) as CNT FROM RTLessorAVSCMTYLINEDROPHardware WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1]
                  + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' and dropdat is null and rcvprtno <> '' ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSXX.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "���M�u���u��w���ͪ��~�����A�Х����ಾ���~����楼���u���ק@�~�C�C" };
                }
            }

            sqlxx = "select * FROM RTLessorAVSCmtylineDROPsndwork WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' ";

            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["REALENGINEER"].ToString() == "" && RSYY.Tables[0].Rows[0]["REALCONSIGNEE"].ToString() == "")
                {
                    return new object[] { 0, "���M�u���u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P�ӡC" };
                }

                if (RSXX.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "" || RSYY.Tables[0].Rows[0]["STOCKCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w�뵲�A���i���ʡC" };
                }

                if (RSXX.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w���������b�ڡA�L�k���Ƶ��סA�гs����T���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT103213.InfoParameters[0].Value = sdata[0];
                cmdRT103213.InfoParameters[1].Value = sdata[1];
                cmdRT103213.InfoParameters[2].Value = sdata[2];
                cmdRT103213.InfoParameters[3].Value = sdata[3];
                cmdRT103213.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT103213.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u�槹�u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����M�u���u�槹�u���ק@�~,���~�T��" + ex };
            }
        }

        //�M�u����
        public object[] smRT103214(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT103214.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINE WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1];
            string sqlyy = "select * FROM RTLessorAVSCmtyLineDROP WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " and ENTRYNO=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            DataSet RSYY = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�D�u�w�@�o�A�L�k����(���u�楲���@�o)�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��D�u���ɡA�L�k���סC" };
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u����ݺM�u���Ƥw�@�o�A���i���槹�u���ק@�~�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣�즹�M�u���u����ݺM�u���ơC" };

            }

            sqlxx = "select count(*) as CNT FROM RTLessorAVSCMTYLINEDROPHardware WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1]
                  + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' and dropdat is null and rcvfinishdat is null ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSXX.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "���M�u���u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~����{��(������β��ॼ����)�A���i���槹�u���ק@�~�C" };
                }
            }

            sqlxx = "select * FROM RTLessorAVSCmtylineDROPsndwork WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' ";

            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "��w�@�o�ɡA���i���槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u���סC" };
                }

                if (RSXX.Tables[0].Rows[0]["BATCHNO"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w���������b�ڡA�L�k���Ƶ��סA�гs����T���C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT103214.InfoParameters[0].Value = sdata[0];
                cmdRT103214.InfoParameters[1].Value = sdata[1];
                cmdRT103214.InfoParameters[2].Value = sdata[2];
                cmdRT103214.InfoParameters[3].Value = sdata[3];
                cmdRT103214.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT103214.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u�楼���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����M�u���u�楼���u���ק@�~,���~�T��" + ex };
            }
        }

        //���ת���
        public object[] smRT103215(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT103215.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCMTYLINE WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1];
            string sqlyy = "select * FROM RTLessorAVSCmtyLineDROP WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " and ENTRYNO=" + sdata[2];
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlyy;
            DataSet RSYY = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "�D�u�w�@�o�A�L�k����(���u�楲���@�o)�C" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                {
                    return new object[] { 0, "�D�u�|���M�u�A�L�k���欣�u�浲�ת���@�~�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣��D�u���ɡA�L�k���סC" };
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�M�u��w���סA���i���欣�u�浲�ת���C" };
                }

                if (RSYY.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u����ݺM�u���Ƥw�@�o�A���i���槹�u���ק@�~�C" };
                }
            }
            else
            {
                return new object[] { 0, "�䤣�즹�M�u���u����ݺM�u���ơC" };

            }

            sqlxx = "select count(*) as CNT FROM RTLessorAVSCMTYLINEDROPHardware WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1]
                  + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' and dropdat is null and rcvfinishdat is null ";
            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSXX.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "���M�u���u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~����{��(������β��ॼ����)�A���i���槹�u���ק@�~�C" };
                }
            }

            sqlxx = "select * FROM RTLessorAVSCmtylineDROPsndwork WHERE COMQ1=" + sdata[0] + " AND LINEQ1=" + sdata[1] + " AND ENTRYNO=" + sdata[2] + " and prtno='" + sdata[3] + "' ";

            cmd.CommandText = sqlxx;
            RSXX = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() == "" || RSYY.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() == "")
                {
                    return new object[] { 0, "�����u��|�����סA���i���浲�ת���@�~�C" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u��w�@�o�A���i����C" };
                }

                if ((RSYY.Tables[0].Rows[0]["SNDWORKDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "") && RSYY.Tables[0].Rows[0]["SNDWORKDAT"].ToString() != "")
                {
                    return new object[] { 0, "���M�u���u����ݺM�u���Ƥw�@�o�A���i���槹�u���ק@�~�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT103215.InfoParameters[0].Value = sdata[0];
                cmdRT103215.InfoParameters[1].Value = sdata[1];
                cmdRT103215.InfoParameters[2].Value = sdata[2];
                cmdRT103215.InfoParameters[3].Value = sdata[3];
                cmdRT103215.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT103215.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u���צ��\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u�M�u���u���ק@�~,���~�T��" + ex };
            }
        }

        //�D�u�M�u���u�@�o
        public object[] smRT103216(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');

            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT103216.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtyLineDROPsndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and entryno=" + sdata[2] + " and prtno='" + sdata[3] + "' ";
            string sqlYY = "select * FROM RTLessorAVSCmtyLineDROP WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and entryno=" + sdata[2];
            string sqlzz = "select count(*) as cnt FROM RTLessorAVSCustRTNHardware WHERE prtno='" + sdata[3] + "' and canceldat is null ";
            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();
            cmd.CommandText = sqlzz;
            DataSet RSZZ = cmd.ExecuteDataSet();
            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "" || RSYY.Tables[0].Rows[0]["UNCLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w���u���סA���i�@�o(���@�o�Х����浲�ת���)" };
                }

                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u��w�@�o�A���i���а���@�o�@�~�C" };
                }
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["CLOSEDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u����ݺM�u��w���סA���i�@�o���u��C" };
                }
            }

            if (RSZZ.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(RSZZ.Tables[0].Rows[0]["CNT"].ToString()) > 0)
                {
                    return new object[] { 0, "�����u��w���ͪ��~��γ�A���i�����@�o(�Х����ફ�~��γ�)�C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT103216.InfoParameters[0].Value = sdata[0];
                cmdRT103216.InfoParameters[1].Value = sdata[1];
                cmdRT103216.InfoParameters[2].Value = sdata[2];
                cmdRT103216.InfoParameters[3].Value = sdata[3];
                cmdRT103216.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT103216.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u��@�o���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k���欣�u��@�o�@�~,���~�T��" + ex };
            }
        }

        //�D�u������u�@�o����
        public object[] smRT103217(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT103217.Connection;
            conn.Open();
            string sqlxx = "select * FROM RTLessorAVSCmtyLinedropsndwork WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and entryno=" + sdata[2] + " and prtno='" + sdata[3] + "' ";
            string sqlYY = "select * FROM RTLessorAVSCmtyLinedrop WHERE comq1=" + sdata[0] + " and lineq1=" + sdata[1] + " and entryno=" + sdata[2];

            cmd.CommandText = sqlxx;
            DataSet RSXX = cmd.ExecuteDataSet();
            cmd.CommandText = sqlYY;
            DataSet RSYY = cmd.ExecuteDataSet();

            if (RSXX.Tables[0].Rows.Count > 0)
            {
                if (RSXX.Tables[0].Rows[0]["BONUSCLOSEYM"].ToString() != "")
                {
                    return new object[] { 0, "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����C" };
                }
                if (RSXX.Tables[0].Rows[0]["DROPDAT"].ToString() == "")
                {
                    return new object[] { 0, "���D�u�M�u���u��|���@�o�A���i����@�o����@�~�C" };
                }
            }

            if (RSYY.Tables[0].Rows.Count > 0)
            {
                if (RSYY.Tables[0].Rows[0]["SNDPRTNO"].ToString() != "" || RSYY.Tables[0].Rows[0]["SNDWORKDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����u����ݺM�u��w�t�~���ͬ��u��A�]��������欣�u��@�o����C" };
                }
            }

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT103217.InfoParameters[0].Value = sdata[0];
                cmdRT103217.InfoParameters[1].Value = sdata[1];
                cmdRT103217.InfoParameters[2].Value = sdata[2];
                cmdRT103217.InfoParameters[3].Value = sdata[3];
                cmdRT103217.InfoParameters[4].Value = sdata[4];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT103217.ExecuteNonQuery();
                return new object[] { 0, "�D�u�M�u���u��@�o���ন�\" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�L�k����D�u���u��@�o����@�~,���~�T���G" + ex };
            }
        }
    }
}
