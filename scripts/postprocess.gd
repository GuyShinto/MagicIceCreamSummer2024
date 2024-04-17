extends CanvasLayer

@onready var heat :ShaderMaterial = $"heat".material

func SetHeat(_value):
	heat.set_shader_parameter("heat", clamp(_value,-1.0,1.0))
