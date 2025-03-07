<%@ Page Title="" Language="C#" MasterPageFile="~/USER.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="m-auto content max-width-1 my-2">
        <div class="content-left">
            <h1>The heaven for bloggers</h1>
            <p>iBlog is a website which lets you submit an article which upon approval will be up on our website and you
                can get a good amount of reach from here!</p>
            <p>My Halloween decorations are staying in the box this year. To be honest, they didn’t make it out of the
                box last year either. My Halloween spirit has officially been bludgeoned to death by teenagers who no
                longer care and a persistent October fear of the Northern California wildfires. And speaking of fear,
                isn’t there more than enough of that going around? Maybe all of us can pretend that Halloween isn’t even
                happening this year?</p>
        </div>
        <div class="content-right">
            <img src="img/home.svg" alt="iBlog">
        </div>
    </div>

    <div class="max-width-1 m-auto">
        <hr>
    </div>
    <div class="home-articles max-width-1 m-auto font2">
        <h2>Featured Articles</h2>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
             <ItemTemplate>
                 <div class="home-article">
                     <div class="home-article-img">
                         <img src="<%# ("admin/img/") + Eval("ImagePath") %>" height="200px" width="100px" alt="article">
                     </div>
                     <div class="home-article-content font1">
                         <asp:HyperLink ID="HyperLink1" runat="server" >
                         </asp:HyperLink>
                         <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("BlogID") %>'><%# Eval("BlogName") %></asp:LinkButton>
                         
                         <div> <%# Eval("Author") %></div>
                         <span><%# FormatDate(Eval("CreatedAt")) %></span>
                     </div>
                 </div>
             </ItemTemplate>
         </asp:Repeater>
         <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Blogs %>' SelectCommand="SELECT * FROM [Blogs] ORDER BY [BlogID] DESC"></asp:SqlDataSource>
     </div>
</asp:Content>

