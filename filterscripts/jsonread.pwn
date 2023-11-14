#include <a_samp>

#define FILE_PATH "scriptfiles/your_json_file.json"

new Float:json_data[256];
new Float:json_value;

forward OnGameModeInit();

public OnGameModeInit()
{
    new handle = JSON_Create(FILE_PATH);

    if (handle != INVALID_JSON_HANDLE)
    {
        while (JSON_ReadNext(handle, json_data, json_value))
        {
            // Hacer algo con los datos leídos, por ejemplo:
            printf("Clave: %s, Valor: %f", json_data, json_value);
        }

        JSON_Close(handle);
    }
    else
    {
        printf("Error al abrir el archivo JSON.");
    }
    return 1;
}
