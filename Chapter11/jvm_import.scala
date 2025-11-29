val session = Session.builder
  .configs(Map( /* conn props */ ))
  .imports(Seq("@code.jar/app-all.jar"))
  .create
