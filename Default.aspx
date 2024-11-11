<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <style type="text/css">
        .grid-container {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            padding: 10px;
        }

        .grid-item {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <script type="text/javascript">
            const reloadGrid = (sortyBy) => $.get(
                `Handlers/RTProxy.ashx?sort=${sortyBy}`
            ).then(response => {
                const movies = response.grid.list;

                const gridItemTemplate = $('.grid-item:first').clone();

                $('.grid-container').html('');

                for (const movie of movies) {
                    const card = gridItemTemplate.clone();

                    $('.k-card-title', card).html(movie.title);
                    $('.k-card-subtitle', card).html(movie.releaseDateText);
                    $('.k-card-body p', card).html(movie.criticsScore.scorePercent == "" ? "-" : movie.criticsScore.scorePercent);
                    $('.k-card-image', card).attr('src', movie.posterUri);
                    $('.k-card-footer', card).html(movie.type);

                    $('.grid-container').append(card);
                }
            });

            const menuItemClicked = (sender, args) => reloadGrid(
                $(args.get_domEvent().target).attr('id')
            );

            $(() => {
                // jquery click event alternative
                //$('.rmRootLink').click(ev => reloadGrid($(ev.target).attr('id')));
            });
        </script>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadMenu ID="MainMenu" runat="server" Skin="MetroTouch" Style="top: 0px; left: 0px; height: 41px" Width="100%" OnClientItemClicked="menuItemClicked">
            <Items>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" Selected="True" ID="newest" Text="Newest Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="popular" Text="Most Popular Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="top_box_office" Text="Top Box Office Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="a_z" Text="A-Z Movies">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>

        <div class="grid-container">
            <asp:Repeater runat="server" ID="Repeater1">
                <ItemTemplate>
                    <div class="grid-item">
                        <telerik:RadCard runat="server" Width="85%" Height="100%">
                            <telerik:CardHeaderComponent runat="server">
                                <telerik:CardTitleComponent runat="server">
                                    <%# ((CardData)Container.DataItem).Title %>
                                </telerik:CardTitleComponent>
                                <telerik:CardSubtitleComponent runat="server">
                                    <%# ((CardData)Container.DataItem).ReleaseDate %>
                                </telerik:CardSubtitleComponent>
                            </telerik:CardHeaderComponent>
                            <telerik:CardBodyComponent runat="server">
                                <p><%# ((CardData)Container.DataItem).CriticsScore %></p>
                                <telerik:CardImageComponent runat="server" src='<%# ((CardData)Container.DataItem).ImageUrl %>'></telerik:CardImageComponent>
                            </telerik:CardBodyComponent>
                            <telerik:CardFooterComponent runat="server">
                                <p><%# ((CardData)Container.DataItem).Type %></p>
                            </telerik:CardFooterComponent>
                        </telerik:RadCard>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
