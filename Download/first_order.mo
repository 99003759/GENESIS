model first_order
  Modelica.Blocks.Sources.Step step annotation(
    Placement(visible = true, transformation(origin = {-80, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction transferFunction(a = {0.05, 1}, b = {0.01})  annotation(
    Placement(visible = true, transformation(origin = {-22, 22}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
equation
  connect(step.y, transferFunction.u) annotation(
    Line(points = {{-68, 22}, {-36, 22}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")));
end first_order;
