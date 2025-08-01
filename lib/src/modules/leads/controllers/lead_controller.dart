import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';
import 'package:api_leads/src/modules/leads/services/i_lead_service.dart';
import 'package:vaden/vaden.dart';

@Api(tag: 'Lead', description: 'Controller para buscar e atualizar leads')
@Controller('/lead')
class LeadController {
  final ILeadService _service;

  LeadController(this._service);

  @ApiOperation(
      summary: 'Atualiza uma Lead',
      description: 'Atualiza uma lead no banco de dados.'
  )
  @ApiResponse(200, description: 'Lead atualizada com sucesso', content: ApiContent(type: 'application/json', schema: LeadDto))
  @ApiResponse(400, description: 'Requisição inválida', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Não autorizado', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Erro interno do servidor', content: ApiContent(type: 'application/json'))
  @Put('/edit')
  Future<LeadDto> update(@Body() LeadDto lead)async {
    return await _service.Update(lead);
  }

  @ApiOperation(
      summary: 'Busca Leads',
      description: 'Busca os Leads com paginação.'
  )
  @ApiResponse(200, description: 'Leads Buscados com sucesso', content: ApiContent(type: 'application/json', schema: LeadDto))
  @ApiResponse(400, description: 'Requisição inválida', content: ApiContent(type: 'application/json'))
  @ApiResponse(401, description: 'Não autorizado', content: ApiContent(type: 'application/json'))
  @ApiResponse(500, description: 'Erro interno do servidor', content: ApiContent(type: 'application/json'))
  @Get()
  Future<Response> getAll(
      @Query('page') int? page,
      @Query('pageSize') int? pageSize,
      ) async {
    final pageNumber = page ?? 1;
    final size = pageSize ?? 10;
    final offset = (pageNumber-1)*size;
      final leads = await _service.getAll(size, offset);
      return Response.ok(leads);
  }
}
