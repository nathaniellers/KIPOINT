<%@ Page Title="Position" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Position.aspx.cs" Inherits="KIPOINT.Other_management.Position" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <style>
         table {
          border-collapse: collapse;
          border-spacing: 0;
        }

        td,
        th {
            padding: 3px;
        }
            
            .auto-style11 {
                width: 450px;
                height: 22px;
            }
            .auto-style13 {
                width: 450px;
                height: 28px;
            }
    
            .auto-style14 {
                margin-left: 0px;
            }
    
            .auto-style17 {
                width: 281px;
                height: 22px;
            }
            .auto-style18 {
                width: 281px;
                height: 28px;
            }
            .auto-style19 {
                height: 22px;
            }
            .auto-style20 {
                width: 383px;
                height: 22px;
            }
            .auto-style21 {
                width: 383px;
                height: 28px;
            }
            .auto-style22 {
                width: 482px;
                height: 22px;
            }
            .auto-style23 {
                width: 482px;
                height: 28px;
            }
    
    </style>

   <div class="card pb-3">
        <div class="container-fluid">


    <table style="width: 100%; height: 130px">
                            <tr>
                                <td class="auto-style22">&nbsp;</td>
                                <td class="auto-style17">&nbsp;</td>
                                <td class="auto-style20">&nbsp;</td>
                                <td style="height: 22px; width: 450px"" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style22">&nbsp;</td>
                <td class="auto-style17">Position Name*</td>
                                <td class="auto-style20">
                    <asp:TextBox ID="txt_position_name" runat="server" Width="200px" Height="25px"></asp:TextBox>
                                </td>
                                <td style="height: 22px; width: 450px"" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style22"></td>
                <td class="auto-style17">Limit*</td>
                                <td class="auto-style20">
                    <asp:TextBox ID="txt_limit" runat="server" Width="200px" Height="25px" TextMode="Number"></asp:TextBox>
                                </td>
                                <td class="auto-style11" colspan="2"></td>
                            </tr>
                            <tr>
                                <td class="auto-style22">&nbsp;</td>
                <td class="auto-style17">Rank*</td>
                                <td class="auto-style20">
                    <asp:TextBox ID="txt_rank" runat="server" Width="200px" Height="25px"></asp:TextBox>
                                </td>
                                <td style="height: 22px; width: 450px"" colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style22">
                                    &nbsp;</td>
                                <td class="auto-style17">
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                </td>
                                <td class="auto-style20">&nbsp;</td>
                                <td class="auto-style19">
                    <asp:Button ID="btn_submit" runat="server" Text="Submit" Width="150px" OnClick="btn_submit_Click" class="btn btn-success" />
                                </td>
                                <td class="auto-style19">
                    <asp:Button ID="btn_cancel" runat="server" Text="Clear" Width="150px" OnClick="btn_cancel_Click" class="btn btn-danger" />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style23"></td>
                                <td class="auto-style18"></td>
                                <td class="auto-style21"></td>
                                <td class="auto-style13" colspan="2"></td>
                            </tr>
                        </table>
                </div>

                
                    <asp:GridView ID="position_view" runat="server" DataKeyNames="id"  OnRowDataBound="OnRowDataBound2"
                    OnRowEditing="OnRowEditing2" OnRowCancelingEdit="OnRowCancelingEdit2" OnRowUpdating="OnRowUpdating2"
                    OnRowDeleting="OnRowDeleting2" EmptyDataText="No records has been added." AutoGenerateEditButton="True"
                    ShowHeaderWhenEmpty="True" AutoGenerateDeleteButton="True" Width="100%" Height="200px" AutoGenerateColumns="False" CssClass="auto-style14" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:TemplateField HeaderText="Position Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_position_name" runat="server" Text='<% #Bind("pname") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_position_name" runat="server" Text='<% #Eval("pname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Limit">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_limit" runat="server" Text='<% #Bind("plimit") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_limit" runat="server" Text='<% #Eval("plimit") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rank">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_rank" runat="server" Text='<% #Bind("prank") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbl_rank" runat="server" Text='<% #Eval("prank") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                       <HeaderStyle BackColor="Black" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="True" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </div>
            



            
                <br />
     
    

</asp:Content>
