import 'package:character_card/domain/character.dart';
import 'package:character_page/dto/catalog_data.dart';

/// Мапа персонажей
CharacterCard characterMapper(CharacterData data) {
  return CharacterCard(
    id: data.id,
    name: data.name,
    status: data.status,
    species: data.species,
    type: data.type,
    gender: data.gender,
    origin: locationMapper(data.origin),
    location: locationMapper(data.location),
    image: data.image,
    episode: data.episode,
    url: data.url,
    created: DateTime.parse(data.created),
  );
}

/// Мапа локаций
CharacterLocation locationMapper(CharacterLocationData data) {
  return CharacterLocation(
    name: data.name,
    url: data.url,
  );
}
