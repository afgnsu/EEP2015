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
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10441.InfoParameters[0].Value = sdata[0];
                cmdRT10441.InfoParameters[1].Value = sdata[1];
                cmdRT10441.InfoParameters[2].Value = sdata[2];
                cmdRT10441.InfoParameters[3].Value = sdata[3];
                cmdRT10441.InfoParameters[4].Value = sdata[4];
                cmdRT10441.InfoParameters[5].Value = sdata[5];
                cmdRT10441.InfoParameters[6].Value = sdata[6];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10441.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
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
        

            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10442.InfoParameters[0].Value = sdata[0];
                cmdRT10442.InfoParameters[1].Value = sdata[1];
                cmdRT10442.InfoParameters[2].Value = sdata[2];
                cmdRT10442.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10442.ExecuteNonQuery();
                return new object[] { 0, "�Τ�_�������������ק@�~���\�C" };
            }
            catch (Exception ex)
            {
                return new object[] { 0, "�Τ�_�������������ק@�~����,���~�T���G" + ex };
            }
        }

        public object[] smRT10443(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10443.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10443.InfoParameters[0].Value = sdata[0];
                cmdRT10443.InfoParameters[1].Value = sdata[1];
                cmdRT10443.InfoParameters[2].Value = sdata[2];
                cmdRT10443.InfoParameters[3].Value = sdata[3];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10443.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10444(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10444.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10444.InfoParameters[0].Value = sdata[0];
                cmdRT10444.InfoParameters[1].Value = sdata[1];
                cmdRT10444.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10444.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10445(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10445.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10445.InfoParameters[0].Value = sdata[0];
                cmdRT10445.InfoParameters[1].Value = sdata[1];
                cmdRT10445.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10445.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
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

            string selectSql = "select * FROM RTLessorAVSCustReturn WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1];
            cmd.CommandText = selectSql;
            DataSet ds = cmd.ExecuteDataSet();
            selectSql = "select * FROM RTLessorAVSCust WHERE CUSID='" + sdata[0] + "'";
            cmd.CommandText = selectSql;
            DataSet ds1 = cmd.ExecuteDataSet();
            selectSql = "select count(*) as cnt FROM RTLessorAVSCustReturnsndwork  WHERE CUSID='" + sdata[0] + "' and ENTRYNO=" + sdata[1] + " and dropdat is null and unclosedat is null and closedat is null";
            cmd.CommandText = selectSql;
            DataSet ds2 = cmd.ExecuteDataSet();

            if (ds1.Tables[0].Rows.Count <= 0)
            {
                return new object[] { 0, "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["CANCELdat"].ToString() != "")
                {
                    return new object[] { 0, "��_����Ƥw�@�o�ɡA���i�����������b�ڧ@�~�C" };
                }

                if (ds.Tables[0].Rows[0]["strbillingdat"].ToString() == "")
                {
                    return new object[] { 0, "�}�l�p�O��ťծɤ��i���������ק@�~�C" };
                }

                if (ds.Tables[0].Rows[0]["paytype"].ToString() == "02")
                {
                    return new object[] { 0, "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u�沣�������b�ڡC" };
                }

                if (ds.Tables[0].Rows[0]["batchno"].ToString() != "" || ds.Tables[0].Rows[0]["FINISHDAT"].ToString() != "")
                {
                    return new object[] { 0, "�����_����Ƥw�������b�ڡA���i���Ʋ��͡C" };
                }

                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (ds1.Tables[0].Rows[0]["CANCELDAT"].ToString() != "")
                    {
                        return new object[] { 0, "�Ȥ��Ƥw�@�o�A�����@�o�_����ơC" };
                    }

                    if (ds1.Tables[0].Rows[0]["DROPdat"].ToString() == "")
                    {
                        return new object[] { 0, "�Ȥ��Ʃ|���h���A���i����_���������b�ڧ@�~�C" };
                    }
                }
            }
            else
            {
                return new object[] { 0, "�䤣��Ȥ�_���D�ɸ�ơA�L�k�����������b�ڵ��ק@�~�C" };
            }

            if (ds2.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(ds2.Tables[0].Rows[0]["cnt"].ToString()) > 0)
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

                if (ds.Tables[0].Rows[0]["paytype"].ToString() == "02")
                {
                    return new object[] { 0, "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u����������b�ڡC" };
                }

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
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10448.InfoParameters[0].Value = sdata[0];
                cmdRT10448.InfoParameters[1].Value = sdata[1];
                cmdRT10448.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10448.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }

        public object[] smRT10449(object[] objParam)
        {
            var ss = (string)objParam[0];
            var sdata = ss.Split(',');
            //�}�Ҹ�Ƴs��
            IDbConnection conn = cmdRT10449.Connection;
            conn.Open();
            //�]�w��J�Ѽƪ���
            try
            {
                cmdRT10449.InfoParameters[0].Value = sdata[0];
                cmdRT10449.InfoParameters[1].Value = sdata[1];
                cmdRT10449.InfoParameters[2].Value = sdata[2];
                /*���o�έp�����G�A�ñN���G��^*/
                double ii = cmdRT10449.ExecuteNonQuery();
                return new object[] { 0, ii };
            }
            catch (Exception ex)
            {
                return new object[] { 0, ex };
            }
        }
    }
}
