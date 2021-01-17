SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create trigger [tr_MStran_alterview] on database for ALTER_VIEW as 

							set ANSI_NULLS ON
							set ANSI_PADDING ON
							set ANSI_WARNINGS ON
							set ARITHABORT ON
							set CONCAT_NULL_YIELDS_NULL ON
							set NUMERIC_ROUNDABORT OFF
							set QUOTED_IDENTIFIER ON

							declare @EventData xml
							set @EventData=EventData()

							exec sys.sp_MStran_ddlrepl @EventData, 2
GO