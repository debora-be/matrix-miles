%{
  configs: [
    %{
      checks: [
        {Credo.Check.Readability.MaxLineLength, max_length: 80}
      ]
    }
  ]
}
